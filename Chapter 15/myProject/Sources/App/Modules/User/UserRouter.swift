import Vapor

struct UserRouter: ViperRouter {
    
    let frontendController = UserFrontendController()
    let apiController = UserApiController()
    let adminController = UserAdminController()

    func boot(routes: RoutesBuilder, app: Application) throws {
        routes.get("sign-in", use: frontendController.loginView)
        
        routes.grouped(UserModelCredentialsAuthenticator())
            .post("sign-in", use: frontendController.login)
        
        routes.grouped(UserModelSessionAuthenticator())
            .get("logout", use: frontendController.logout)
        
        let api = routes.grouped("api", "user")

        api.grouped(UserModelCredentialsAuthenticator())
            .post("login", use: apiController.login)
        
        routes.post("redirect", use: frontendController.signInWithApple)
        api.post("sign-in-with-apple", use: apiController.signInWithApple)

        let protected = routes.grouped([
            UserModelSessionAuthenticator(),
            UserModel.redirectMiddleware(path: "/")
        ])
        let user = protected.grouped("admin", "user")
        user.get("push", use: adminController.pushView)
        user.post("push", use: adminController.push)

    }
}
