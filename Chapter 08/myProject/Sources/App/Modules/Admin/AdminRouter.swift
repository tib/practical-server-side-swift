import Vapor

struct AdminRouter: RouteCollection {

    let controller = AdminController()

    func boot(routes: RoutesBuilder) throws {

        routes.grouped(UserModel.redirectMiddleware(path: "/sign-in/"))
            .get("admin", use: controller.dashboardView)
    }
}
