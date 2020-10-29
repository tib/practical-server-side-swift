import Vapor

struct FrontendRouter: RouteCollection {
    
    let controller = FrontendController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.grouped(UserModelSessionAuthenticator()).get(use: controller.homeView)
    }

}
