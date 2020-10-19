import Vapor

struct AdminRouter: ViperRouter {

    let controller = AdminController()

    func boot(routes: RoutesBuilder, app: Application) throws {

        routes.grouped(UserModelSessionAuthenticator())
            .get("admin", use: controller.homeView)
    }
}
