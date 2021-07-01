import Vapor

struct BlogModule: ModuleInterface {
    static let key = "blog"

    func boot(_ app: Application) throws {
        app.migrations.add(BlogMigration_v1())
        app.migrations.add(BlogMigrationSeed())
        
        try BlogRouter().boot(routes: app.routes)
    }
}
