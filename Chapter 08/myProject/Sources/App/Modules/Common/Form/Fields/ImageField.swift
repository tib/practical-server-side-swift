import Foundation
import Vapor
import Liquid

fileprivate extension File {

    var byteBuffer: ByteBuffer { data }

    var dataValue: Data? { byteBuffer.getData(at: 0, length: byteBuffer.readableBytes) }
}


final class ImageField: FormField<ImageInput, ImageFieldView> {

    public struct TemporaryImage {
        public let key: String
        public let name: String
        
        public init(key: String, name: String) {
            self.key = key
            self.name = name
        }
    }

    let path: String
    
    public var imageKey: String? = nil {
        didSet {
            output.currentKey = imageKey
        }
    }
    
    var temporaryImage: TemporaryImage? = nil {
        didSet {
            output.temporaryKey = temporaryImage?.key
            output.temporaryName = temporaryImage?.name
        }
    }
    
    var shouldRemoveImage: Bool = false {
        didSet {
            output.remove = shouldRemoveImage
        }
    }

    public var isEmptyImage: Bool {
        if shouldRemoveImage {
            return true
        }
        return temporaryImage == nil && imageKey == nil
    }
    
    public init(key: String, path: String) {
        self.path = path
         
        super.init(key: key, input: .init(key: key), output: .init(key: key))
    }

    override func write(req: Request) -> EventLoopFuture<Void> {
        var future: EventLoopFuture<String?> = req.eventLoop.future(nil)
        /// if there is a delete flag we simply remove the original file
        if shouldRemoveImage {
            future = updateImageKeyAndRemoveOldIfNeeded(nil, req: req)
        }
        else if let file = temporaryImage {
            let destination = path + file.name

            /// if the target file already exists we give it a timestamp as a prefix
            future = req.fs.exists(key: destination).map { [unowned self] exists -> String in
                    if exists {
                        let formatter = DateFormatter()
                        formatter.dateFormat="y-MM-dd-HH-mm-ss-"
                        let prefix = formatter.string(from: .init())
                        return path + prefix + file.name
                    }
                    return destination
                }
                .flatMap { dest in
                    req.fs.move(key: file.key, to: dest).flatMap { [unowned self] _ in
                        temporaryImage = nil
                        return updateImageKeyAndRemoveOldIfNeeded(dest, req: req)
                    }
                }
        }
        return future.flatMap { [unowned self] key in
            if shouldRemoveImage || key != nil {
                imageKey = key
            }
            return writeBlock?(req, self) ?? req.eventLoop.future()
        }
    }
    
    override func process(req: Request) -> EventLoopFuture<Void> {
        /// process input
        input.process(req: req)
        /// set current image key
        imageKey = input.currentKey
        /// update remaining output fields
        if let key = input.temporaryKey, let name = input.temporaryName {
            temporaryImage = .init(key: key, name: name)
        }
        shouldRemoveImage = input.remove

        var future = req.eventLoop.future()
        /// if remove, delete temporary file if exists
        if shouldRemoveImage {
            future = deleteTmpFileIfExists(req: req)
        }
        /// if there is new file data, upload it as tmp image
        else if let file = input.file, let data = file.dataValue, !data.isEmpty {
            let key = "tmp/\(UUID().uuidString).tmp"
            /// remove previous temp file and upload new one
            future = deleteTmpFileIfExists(req: req).flatMap {
                req.fs.upload(key: key, data: data).map { [unowned self] url in
                    temporaryImage = .init(key: key, name: file.filename)
                }
            }
        }
        /// after upload, call remaining process block
        return future.flatMap { [unowned self] in
            return processBlock?(req, self) ?? req.eventLoop.future()
        }
    }

    // MARK: - helpers
    
    private func deleteTmpFileIfExists(req: Request) -> EventLoopFuture<Void> {
        if let file = temporaryImage {
            return req.fs.delete(key: file.key).map { [unowned self] in
                temporaryImage = nil
            }
        }
        return req.eventLoop.future()
    }

    private func updateImageKeyAndRemoveOldIfNeeded(_ key: String?, req: Request) -> EventLoopFuture<String?> {
        var future = req.eventLoop.future()
        if let key = imageKey {
            future = future.flatMap { req.fs.delete(key: key) }
        }
        return future.map { [unowned self] in
            imageKey = key
            return key
        }
    }
}




