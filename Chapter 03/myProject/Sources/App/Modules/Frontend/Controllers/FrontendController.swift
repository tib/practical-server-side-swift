import Vapor
import LoremSwiftum

struct FrontendController {
    
    func homeView(req: Request) throws -> Response {
        let context = WebHomeContext(title: "myPage - Home", paragraphs: [
            Lorem.sentences(6),
            Lorem.sentences(8),
        ])
        let template = WebHomeTemplate(context)
        return req.templates.renderHtml(template)
    }
}
