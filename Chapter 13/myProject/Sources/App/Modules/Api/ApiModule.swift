import Vapor

struct ApiModule: ModuleInterface {
    
    func boot(_ app: Application) throws {
        app.middleware.use(ApiErrorMiddleware())
    }
}
