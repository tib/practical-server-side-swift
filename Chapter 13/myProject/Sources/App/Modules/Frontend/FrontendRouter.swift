import Vapor
import ViperKit

struct FrontendRouter: ViperRouter {
    
    let controller = FrontendController()
    
    func boot(routes: RoutesBuilder, app: Application) throws {
        routes.grouped(UserModelSessionAuthenticator())
            .get(use: self.controller.homeView)
    }

}
