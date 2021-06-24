import Vapor

struct UserModule: ModuleInterface {

    static let key = "user"

    func boot(_ app: Application) throws {
        app.migrations.add(UserMigration_v1())
        app.migrations.add(UserMigrationSeed())
        
        app.middleware.use(UserModelSessionAuthenticator())
        app.middleware.use(UserTemplateScopeMiddleware())
        
        try UserRouter().boot(routes: app.routes)
    }
}
