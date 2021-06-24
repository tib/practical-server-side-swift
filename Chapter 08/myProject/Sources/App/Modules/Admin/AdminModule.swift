import Vapor

struct AdminModule: ModuleInterface {
    
    static let key = "admin"

    func boot(_ app: Application) throws {
        try AdminRouter().boot(routes: app.routes)
    }
}
