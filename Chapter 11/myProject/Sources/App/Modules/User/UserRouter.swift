import Vapor
import ViperKit

struct UserRouter: ViperRouter {
    
    let controller = UserFrontendController()
    let apiController = UserApiController()
    
    func boot(routes: RoutesBuilder, app: Application) throws {
        routes.get("sign-in", use: self.controller.loginView)
        
        routes.grouped(UserModelCredentialsAuthenticator())
            .post("sign-in", use: self.controller.login)
        
        routes.grouped(UserModelSessionAuthenticator())
            .get("logout", use: self.controller.logout)
        
        let api = routes.grouped("api", "user")

        api.grouped(UserModelCredentialsAuthenticator())
            .post("login", use: self.apiController.login)

    }
}
