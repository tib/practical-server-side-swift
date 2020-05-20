import Vapor
import Leaf

struct ModularViewFiles: LeafFiles {
 
    let workingDirectory: String
    let modulesDirectory: String
    let alternateDirectory: String
    let nioLeafFiles: NIOLeafFiles
    
    init(workingDirectory: String,
         modulesDirectory: String = "Sources/App/Modules",
         alternateDirectory: String = "Resources",
         fileio: NonBlockingFileIO)
    {
        self.workingDirectory = workingDirectory
        self.modulesDirectory = modulesDirectory
        self.alternateDirectory = alternateDirectory
        self.nioLeafFiles = NIOLeafFiles(fileio: fileio)
    }

    func file(path: String, on eventLoop: EventLoop) -> EventLoopFuture<ByteBuffer> {
        let viewsDir = "Views"
        let resourcesPath = self.alternateDirectory + "/" + viewsDir
        let ext = ".leaf"
        
        let name = path.replacingOccurrences(of: ext, with: "")
        let resourceFile = resourcesPath + name + ext

        if FileManager.default.fileExists(atPath: resourceFile) {
            return self.nioLeafFiles.file(path: self.workingDirectory + resourceFile,
                                          on: eventLoop)
        }

        let components = name.split(separator: "/")
        let pathComponents = [String(components.first!), viewsDir] +
                                 components.dropFirst().map { String($0) }

        let moduleFile = self.modulesDirectory + "/" +
            pathComponents.joined(separator: "/") + ext

        return self.nioLeafFiles.file(path: self.workingDirectory + moduleFile,
                                      on: eventLoop)
    }
}
