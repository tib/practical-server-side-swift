import Vapor

struct BlogModule: Module {

    func boot(_ app: Application) throws {
        app.migrations.add(BlogMigration_v1())
        app.migrations.add(BlogMigrationSeed())
        
        app.commands.use(BlogCommandGroup(), as: "blog")
        
        try BlogRouter().boot(routes: app.routes)
    }
}

