import Vapor

struct AdminRouter: RouteCollection {
    
    let controller = AdminFrontendController()

    func boot(routes: RoutesBuilder) throws {
        routes
            .grouped(
                AuthenticatedUser.redirectMiddleware(
                    path: "/sign-in/"
                )
            )
            .get("admin", use: controller.dashboardView)
    }
}
