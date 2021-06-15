import Vapor
import Tau
import Fluent

struct BlogFrontendController {
    
    func blogView(req: Request) throws -> EventLoopFuture<View> {
        BlogPostModel.query(on: req.db)
            .sort(\.$date, .descending)
            .with(\.$category)
            .all()
            .mapEach(\.templateData)
            .flatMap {
                req.tau.render(template: "Blog/Frontend/Blog", context: [
                    "title": .string("myPage - Blog"),
                    "posts": .array($0),
                ])
            }
    }
    
    //...
    
    func postView(req: Request) throws -> EventLoopFuture<Response> {
        let slug = req.url.path.trimmingCharacters(in: .init(charactersIn: "/"))

        return BlogPostModel.query(on: req.db)
            .filter(\.$slug == slug)
            .with(\.$category)
            .first()
            .flatMap { post in
                guard let post = post else {
                    return req.eventLoop.future(req.redirect(to: "/"))
                }
                return req.tau.render(template: "Blog/Frontend/Post", context: [
                    "title": .string("myPage - \(post.title)"),
                    "post": post.templateData,
                ]).encodeResponse(for: req)
            }
    }
    
}
