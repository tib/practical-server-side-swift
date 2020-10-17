import Vapor
import Fluent
import Leaf

struct BlogFrontendController {

    func blogView(req: Request) throws -> EventLoopFuture<View> {

        return BlogPostModel.query(on: req.db)
            .sort(\.$date, .descending)
            .with(\.$category)
            .all()
            .mapEach(\.viewContext)
            .flatMap {
                let context: LeafRenderer.Context = [
                    "title": .string("myPage - Blog"),
                    "posts": .array($0),
                ]
                return req.leaf.render(template: "blog", context: context)
            }
    }

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
                let context: LeafRenderer.Context = [
                    "title": .string("myPage - \(post.title)"),
                    "post": post.viewContext,
                ]
                return req.leaf.render(template: "post", context: context).encodeResponse(for: req)
            }
    }
}
