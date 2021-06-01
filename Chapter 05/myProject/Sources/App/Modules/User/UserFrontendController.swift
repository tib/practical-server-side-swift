import Vapor
import Fluent
import Tau

struct UserFrontendController {

    func loginView(req: Request) throws -> EventLoopFuture<View> {
        let form = Form(action: .init(url: "/sign-in/"), fields: [
            TextFieldView(key: "email", required: true, format: .email),
            TextFieldView(key: "password", required: true, format: .password),
        ], submit: "Sign in")

        return req.tau.render(template: "User/Frontend/Login", context: [
            "title": "myPage - Sign in",
            "form": form.encodeToTemplateData()
        ])
    }
    
    func login(req: Request) throws -> EventLoopFuture<Response> {
        if let user = req.auth.get(UserModel.self) {
            req.session.authenticate(user)
            return req.eventLoop.future(req.redirect(to: "/"))
        }
        struct Input: Decodable {
            let email: String?
            let password: String?
        }
        let input = try req.content.decode(Input.self)
        
        let form = Form(action: .init(url: "/sign-in/"), error: "Invalid email or password", fields: [
            TextFieldView(key: "email", required: true, value: input.email ?? "", format: .email),
            TextFieldView(key: "password", required: true, value: input.password ?? "", format: .password),
        ], submit: "Sign in")

        return req.tau.render(template: "User/Frontend/Login", context: [
            "title": "myPage - Sign in",
            "form": form.encodeToTemplateData()
        ]).encodeResponse(for: req)
    }

    func logout(req: Request) throws -> Response {
        req.auth.logout(UserModel.self)
        req.session.unauthenticate(UserModel.self)
        return req.redirect(to: "/")
    }

}
