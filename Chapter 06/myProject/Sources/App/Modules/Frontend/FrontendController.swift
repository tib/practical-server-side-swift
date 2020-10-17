import Vapor
import Leaf

struct FrontendController {
    
    func homeView(req: Request) throws -> EventLoopFuture<View> {
        var email: String?
        if let user = req.auth.get(UserModel.self) {
            email = user.email
        }
        return req.leaf.render(template: "Frontend/Home", context: [
            "title": .string("myPage - Home"),
            "header": .string("Hi there, "),
            "message": .string("welcome to my awesome page!"),
            "isLoggedIn": .bool(email != nil),
            "email": .string(email),
        ])
    }
}
