import Vapor

struct UserRouter: RouteCollection {
    
    let controller = UserFrontendController()
    let apiController = UserApiController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("sign-in", use: controller.loginView)
        
        routes.grouped(UserModelCredentialsAuthenticator())
            .post("sign-in", use: controller.login)
        
        routes.grouped(UserModelSessionAuthenticator())
            .get("logout", use: controller.logout)
        
        let api = routes.grouped("api", "user")

        api.grouped(UserModelCredentialsAuthenticator())
            .post("login", use: apiController.login)
    }
}
