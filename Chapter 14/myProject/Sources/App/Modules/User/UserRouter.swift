import Vapor

struct UserRouter: ViperRouter {
    
    let controller = UserFrontendController()
    let apiController = UserApiController()

    func boot(routes: RoutesBuilder, app: Application) throws {
        routes.get("sign-in", use: controller.loginView)
        
        routes.grouped(UserModelCredentialsAuthenticator())
            .post("sign-in", use: controller.login)
        
        routes.grouped(UserModelSessionAuthenticator())
            .get("logout", use: controller.logout)
        
        let api = routes.grouped("api", "user")

        api.grouped(UserModelCredentialsAuthenticator())
            .post("login", use: apiController.login)
        
        routes.post("redirect", use: self.controller.signInWithApple)
        api.post("sign-in-with-apple", use: self.apiController.signInWithApple)
    }
}
