import Vapor
import Fluent
import FluentSQLiteDriver

final class UtilityDatabaseTransferCommand: Command {
    
    static let name = "database-transfer"

    struct Signature: CommandSignature { }
        
    let help = "Transfer database models from one db to another"
    
    func run(using context: CommandContext, signature: Signature) throws {
        let app = context.application
        
        app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite, isDefault: false)

        let frames = ["⠋","⠙","⠹","⠸","⠼","⠴","⠦","⠧","⠇","⠏"]
            .map { $0 + " Transfer in progress..."}
        
        let loadingBar = context.console.customActivity(frames: frames)

        
        
        let sourceDb = app.databases.database(.sqlite,
                                              logger: app.logger,
                                              on: app.eventLoopGroup.next())!

        let targetDb = app.databases.database(.psql,
                                              logger: app.logger,
                                              on: app.eventLoopGroup.next())!
        
        loadingBar.start()
        
        do {
            // wipe target db first
            try UserModel.query(on: targetDb).delete().wait()
            try BlogPostModel.query(on: targetDb).delete().wait()
            try BlogCategoryModel.query(on: targetDb).delete().wait()

            // create existing items on the target db
            try UserModel.query(on: sourceDb).all()
            .flatMap {
                $0.map { UserModel(id: $0.id, email: $0.email, password: $0.password) }
                    .create(on: targetDb)
            }
            .wait()
            
            try BlogCategoryModel.query(on: sourceDb).all().flatMap {
                $0.map { BlogCategoryModel(id: $0.id, title: $0.title) }
                    .create(on: targetDb)
            }.wait()
            
            try BlogPostModel.query(on: sourceDb)
                .with(\.$category)
                .all()
                .flatMap {
                    $0.map { BlogPostModel(id: $0.id,
                                       title: $0.title,
                                       slug: $0.slug,
                                       image: $0.image,
                                       excerpt: $0.excerpt,
                                       date: $0.date,
                                       content: $0.content,
                                       categoryId: $0.category.id!) }
                    .create(on: targetDb)
            }.wait()

            loadingBar.succeed()
        }
        catch {
            loadingBar.fail()
            context.console.error("Error: \(error.localizedDescription)")
        }
    }
}
