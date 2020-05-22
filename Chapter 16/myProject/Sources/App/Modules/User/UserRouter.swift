import Vapor
import ViperKit

struct UserRouter: ViperRouter {
    
    let frontendController = UserFrontendController()
    let apiController = UserApiController()
    let adminController = UserAdminController()
    
    func boot(routes: RoutesBuilder, app: Application) throws {
        routes.get("sign-in", use: self.frontendController.loginView)
        routes.grouped(UserModelCredentialsAuthenticator()).post("sign-in", use: self.frontendController.login)
        routes.grouped(UserModelSessionAuthenticator()).get("logout", use: self.frontendController.logout)
        routes.post("redirect", use: self.frontendController.signInWithApple)

        let protected = routes.grouped([
            UserModelSessionAuthenticator(),
            UserModel.redirectMiddleware(path: "/")
        ])
        let user = protected.grouped("admin", "user")
        user.get("push", use: self.adminController.pushView)
        user.post("push", use: self.adminController.push)

        let publicApi = routes.grouped("api", "user")
        let privateApi = publicApi.grouped([
            UserTokenModel.authenticator(),
            UserModel.guardMiddleware(),
        ])

        publicApi.grouped(UserModelCredentialsAuthenticator()).post("login", use: self.apiController.login)
        publicApi.post("sign-in-with-apple", use: self.apiController.signInWithApple)
        privateApi.post("devices", use: self.apiController.registerDevice)
    }
}
