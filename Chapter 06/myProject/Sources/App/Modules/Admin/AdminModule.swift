import Vapor

struct AdminModule: Module {

    func boot(_ app: Application) throws {
        try AdminRouter().boot(routes: app.routes)
    }
}
