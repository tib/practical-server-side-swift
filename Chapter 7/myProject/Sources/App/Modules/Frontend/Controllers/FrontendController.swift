import Foundation
import Vapor

struct FrontendController {
    
    func homeView(req: Request) throws -> EventLoopFuture<View> {
        var email: String?
        if let user = req.auth.get(UserModel.self) {
            email = user.email
        }
        struct Context: Encodable {
            let title: String
            let header: String
            let message: String
            let email: String?
        }
        let context = Context(title: "myPage - Home",
                              header: "Hi there,",
                              message: "welcome to my awesome page!",
                              email: email)
        return req.view.render("Frontend/Home", context)
    }
}
