import Vapor
import LoremSwiftum

struct FrontendController {
    
    func homeView(req: Request) throws -> Response {
        let ctx = WebHomeContext(title: "myPage - Home", paragraphs: [
            Lorem.sentences(6),
            Lorem.sentences(8),
        ])
        return req.html.render(WebHomeTemplate(req, context: ctx))
    }
}
