import Vapor

struct BlogModule: ModuleInterface {

    static let key = "blog"
    
    func boot(_ app: Application) throws {
        app.migrations.add(BlogMigration_v1())
        app.migrations.add(BlogMigrationSeed())
        
        app.commands.use(BlogCommandGroup(), as: Self.key)
        
        try BlogRouter().boot(routes: app.routes)
    }
}

