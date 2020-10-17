import Vapor
import Leaf

struct FrontendController {
    
    func homeView(req: Request) throws -> EventLoopFuture<View> {
        return req.leaf.render(template: "home", context: [
            "title": "myPage - Home",
            "header": "Hi there,",
            "message": "welcome to my awesome page!"
        ])
    }
}
