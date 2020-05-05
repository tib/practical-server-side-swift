import Vapor

struct FrontendRouter: RouteCollection {
    
    let controller = FrontendController()
    
    func boot(routes: RoutesBuilder) throws {
        
        routes.get(use: self.controller.homeView)
        routes.get("about", use: self.controller.aboutView)
    }

}
