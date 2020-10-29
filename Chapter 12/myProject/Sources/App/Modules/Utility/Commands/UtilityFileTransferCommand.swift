import Vapor
import Fluent

final class UtilityFileTransferCommand: Command {
    
    static let name = "file-transfer"

    struct Signature: CommandSignature { }
        
    let help = "Transfers public files into the assets folder for the blog posts"
    
    func run(using context: CommandContext, signature: Signature) throws {
        let app = context.application

        let frames = ["⠋","⠙","⠹","⠸","⠼","⠴","⠦","⠧","⠇","⠏"]
            .map { $0 + " File transfer in progress..."}

        let loadingBar = context.console.customActivity(frames: frames)
        loadingBar.start()
        
        let publicPath = app.directory.publicDirectory
        let assetsPath = publicPath + "/assets/"

        do {
            let models = try BlogPostModel.query(on: app.db).all().wait()
            
            let originalModels = models
                .filter { $0.imageKey == nil && $0.image.hasPrefix("/images/posts/") }
            
            for model in originalModels {
                let key = "/blog/posts/" + UUID().uuidString + ".jpg"
                try FileManager.default.moveItem(atPath: publicPath + model.image,
                                                 toPath: assetsPath + key)
                model.imageKey = key
                model.image = "http://localhost:8080/assets" + key
                try model.update(on: app.db).wait()
            }
            loadingBar.succeed()
        }
        catch {
            loadingBar.fail()
            context.console.error("Error: \(error.localizedDescription)")
        }
    }
}
