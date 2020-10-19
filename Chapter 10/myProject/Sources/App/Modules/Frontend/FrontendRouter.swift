import Vapor

struct FrontendRouter: ViperRouter {
    
    let controller = FrontendController()
    
    func boot(routes: RoutesBuilder, app: Application) throws {
        routes.grouped(UserModelSessionAuthenticator()).get(use: controller.homeView)
    }

}
