import Vapor
import Leaf

struct ModularViewFiles: LeafSource {
    let rootDirectory: String
    let modulesDirectory: String
    let resourcesDirectory: String
    let viewsFolderName: String
    let fileExtension: String
    let fileio: NonBlockingFileIO

    init(rootDirectory: String,
         modulesDirectory: String,
         resourcesDirectory: String,
         viewsFolderName: String,
         fileExtension: String,
         fileio: NonBlockingFileIO) {

        self.rootDirectory = rootDirectory
        self.modulesDirectory = modulesDirectory
        self.resourcesDirectory = resourcesDirectory
        self.viewsFolderName = viewsFolderName
        self.fileExtension = fileExtension
        self.fileio = fileio
    }

    func file(template: String,
              escape: Bool = false,
              on eventLoop: EventLoop) -> EventLoopFuture<ByteBuffer> {
        let resourcesPath = self.resourcesDirectory + "/" + self.viewsFolderName + "/"
        let ext = "." + self.fileExtension
        let resourceFile = resourcesPath + template + ext
        if FileManager.default.fileExists(atPath: resourceFile) {
            return self.read(path: self.rootDirectory + resourceFile, on: eventLoop)
        }
        let components = template.split(separator: "/")
        let pathComponents = [String(components.first!), self.viewsFolderName] +
            components.dropFirst().map { String($0) }
        let moduleFile = self.modulesDirectory + "/" + pathComponents.joined(separator: "/") + ext
        return self.read(path: self.rootDirectory + moduleFile, on: eventLoop)
    }

    private func read(path: String, on eventLoop: EventLoop) -> EventLoopFuture<ByteBuffer> {
        self.fileio.openFile(path: path, eventLoop: eventLoop)
        .flatMapErrorThrowing { _ in throw LeafError(.noTemplateExists(path)) }
        .flatMap { handle, region in
            self.fileio.read(fileRegion: region, allocator: .init(), eventLoop: eventLoop)
            .flatMapThrowing { buffer in
                try handle.close()
                return buffer
            }
        }
    }
}
