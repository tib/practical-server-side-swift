import Vapor
import Fluent
import Tau

struct UserFrontendController {

    private func render(_ req: Request, _ form: UserLoginForm) -> EventLoopFuture<View> {
        return req.tau.render(template: "User/Frontend/Login", context: [
            "title": "myPage - Sign in",
            "form": form.encodeToTemplateData()
        ])
    }

    func loginView(req: Request) throws -> EventLoopFuture<View> {
        render(req, .init())
    }
    
    func login(req: Request) throws -> EventLoopFuture<Response> {
        if let user = req.auth.get(UserModel.self) {
            req.session.authenticate(user)
            return req.eventLoop.future(req.redirect(to: "/"))
        }
        let form = UserLoginForm()
        form.error = "Invalid email or password"
        return render(req, form).encodeResponse(for: req)
    }

    func logout(req: Request) throws -> Response {
        req.auth.logout(UserModel.self)
        req.session.unauthenticate(UserModel.self)
        return req.redirect(to: "/")
    }

}
