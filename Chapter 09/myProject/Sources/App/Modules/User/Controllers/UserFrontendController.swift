import Vapor
import Fluent
import Leaf

struct UserFrontendController {

    func loginView(req: Request) throws -> EventLoopFuture<View> {
        req.leaf.render(template: "User/Frontend/Login", context: [
            "title": .string("myPage - Sign in"),
        ])
    }
    
    func login(req: Request) throws -> Response {
        guard let user = req.auth.get(UserModel.self) else {
            throw Abort(.unauthorized)
        }
        req.session.authenticate(user)
        return req.redirect(to: "/")
    }

    func logout(req: Request) throws -> Response {
        req.auth.logout(UserModel.self)
        req.session.unauthenticate(UserModel.self)
        return req.redirect(to: "/")
    }
}
