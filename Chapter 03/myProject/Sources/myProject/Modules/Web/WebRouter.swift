import Vapor

struct WebRouter: RouteCollection {
    
    let frontendController = WebFrontendController()

    func boot(
        routes: any RoutesBuilder
    ) throws {
        routes.get(use: frontendController.homeView)
    }
}
