import Vapor
import Leaf

struct AdminController {
    
    func homeView(req: Request) throws -> EventLoopFuture<View> {
        let user = try req.auth.require(UserModel.self) 
        return req.leaf.render(template: "Admin/Home", context: [
            "header": .string("Hi \(user.email)"),
            "message": .string("welcome to the CMS!"),
        ])
    }
}
