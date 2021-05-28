import Tau

struct ModuleTemplateSource: NonBlockingFileIOSource {
    
    let rootDirectory: String
    let modulesLocation: String
    let folderName: String
    let fileExtension: String
    let fileio: NonBlockingFileIO
    
    func file(template: String, escape: Bool = false, on eventLoop: EventLoop) -> EventLoopFuture<ByteBuffer> {
        let ext = "." + fileExtension
        let components = template.split(separator: "/")
        let pathComponents = [String(components.first!), folderName] + components.dropFirst().map { String($0) }
        let moduleFile = modulesLocation + "/" + pathComponents.joined(separator: "/") + ext
        return read(path: rootDirectory + moduleFile, on: eventLoop)
    }
}
