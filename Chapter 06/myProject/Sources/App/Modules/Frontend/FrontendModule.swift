import Vapor

struct FrontendModule: Module {
    
    func boot(_ app: Application) throws {
        try FrontendRouter().boot(routes: app.routes)
    }
}
