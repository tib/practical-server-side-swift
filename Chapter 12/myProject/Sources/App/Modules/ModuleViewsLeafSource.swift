import Vapor
import Leaf

protocol FileIOLeafSource: LeafSource {

    var fileio: NonBlockingFileIO { get }
    
    func read(path: String, on eventLoop: EventLoop) -> EventLoopFuture<ByteBuffer>
}

extension FileIOLeafSource {
    func read(path: String, on eventLoop: EventLoop) -> EventLoopFuture<ByteBuffer> {
        fileio.openFile(path: path, eventLoop: eventLoop)
        .flatMapErrorThrowing { _ in throw LeafError(.noTemplateExists(path)) }
        .flatMap { handle, region in
            fileio.read(fileRegion: region, allocator: .init(), eventLoop: eventLoop)
            .flatMapThrowing { buffer in
                try handle.close()
                return buffer
            }
        }
    }
}

struct ModuleViewsLeafSource: FileIOLeafSource {

    let rootDirectory: String
    let modulesLocation: String
    let viewsFolderName: String
    let fileExtension: String
    let fileio: NonBlockingFileIO

    func file(template: String, escape: Bool = false, on eventLoop: EventLoop) -> EventLoopFuture<ByteBuffer> {
        let ext = "." + fileExtension
        let components = template.split(separator: "/")
        let pathComponents = [String(components.first!), viewsFolderName] + components.dropFirst().map { String($0) }
        let moduleFile = modulesLocation + "/" + pathComponents.joined(separator: "/") + ext
        return read(path: rootDirectory + moduleFile, on: eventLoop)
    }
}
