import Vapor
import Tau
import LoremSwiftum

struct FrontendController {
    func homeView(req: Request) throws -> EventLoopFuture<View> {
        return req.tau.render(template: "home", context: [
            "title": "myPage - Home",
            "icon": "👋",
            "header": "Hello,",
            "message": "welcome to my Vapor powered website.",
            "paragraphs": .array([
                Lorem.sentences(6),
                Lorem.sentences(8),
            ]),
            "link": .dictionary([
                "label": "Read my blog →",
                "url": "/blog/",
            ])
        ])
    }
}
