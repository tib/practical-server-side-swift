import Vapor

struct WebRouter: RouteCollection {
    
    let controller = WebFrontendController()

    func boot(routes: RoutesBuilder) throws {
        routes.get(use: controller.homeView)
    }
}
