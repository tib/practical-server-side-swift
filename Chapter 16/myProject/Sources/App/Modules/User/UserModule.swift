import Vapor

struct UserModule: ModuleInterface {

    let router = UserRouter()

    func boot(_ app: Application) throws {
        app.migrations.add(UserMigrations.v1())
        app.migrations.add(UserMigrations.seed())
        
        app.middleware.use(UserSessionAuthenticator())
        app.middleware.use(UserTokenAuthenticator())
        
        try router.boot(routes: app.routes)
    }
}
