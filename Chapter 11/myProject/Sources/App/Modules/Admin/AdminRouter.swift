import Vapor

struct AdminRouter: RouteCollection {

    let controller = AdminController()

    func boot(routes: RoutesBuilder) throws {

        routes.grouped(UserModelSessionAuthenticator())
            .get("admin", use: controller.homeView)
    }
}
