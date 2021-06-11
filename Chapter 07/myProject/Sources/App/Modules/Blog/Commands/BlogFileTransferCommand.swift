import Vapor
import Fluent
import Liquid

final class BlogFileTransferCommand: Command {
    
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

        do {
            let allModels = try BlogPostModel.query(on: app.db).all().wait()
            let originalModels = allModels.filter { $0.image.hasPrefix("/img/posts/") }

            for model in originalModels {
                let key = "blog/posts/" + UUID().uuidString + ".jpg"
                let imageData = try Data(contentsOf: URL(fileURLWithPath: publicPath + model.image))

                _ = try app.fs.upload(key: key, data: imageData).wait()
                model.image = key
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
