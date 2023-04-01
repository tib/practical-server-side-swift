import Vapor

struct WebModule: ModuleInterface {

    let router = WebRouter()

    func boot(_ app: Application) throws {
        try router.boot(routes: app.routes)
    }
}
