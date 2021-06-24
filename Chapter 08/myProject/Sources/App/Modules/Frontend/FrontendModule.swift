import Vapor

struct FrontendModule: ModuleInterface {
    
    static let key = "frontend"
    
    func boot(_ app: Application) throws {
        try FrontendRouter().boot(routes: app.routes)
    }
}
