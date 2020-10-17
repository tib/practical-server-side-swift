import Vapor
import Fluent
import Leaf

struct UserFrontendController {

    func loginView(req: Request) throws -> EventLoopFuture<View> {
        let context: LeafRenderer.Context = [
            "title": .string("myPage - Sign in"),
        ]
        return req.leaf.render(template: "User/Frontend/Login", context: context)
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
