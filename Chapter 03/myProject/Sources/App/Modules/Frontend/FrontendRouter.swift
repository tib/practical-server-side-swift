import Vapor

struct FrontendRouter: RouteCollection {
    
    let controller = FrontendController()

    func boot(routes: RoutesBuilder) throws {
        routes.get(use: controller.homeView)
    }
}
