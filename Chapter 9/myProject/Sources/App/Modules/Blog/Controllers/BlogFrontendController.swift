import Vapor
import Fluent

struct BlogFrontendController {
    
    func blogView(req: Request) throws -> EventLoopFuture<View> {
        struct Context: Encodable {
            struct PostWithCategory: Encodable {
                var category: BlogCategoryModel.ViewContext
                var post: BlogPostModel.ViewContext
            }
            let title: String
            let items: [PostWithCategory]
        }

        return BlogPostModel.query(on: req.db)
            .sort(\.$date, .descending)
            .with(\.$category)
            .all()
            .mapEach { Context.PostWithCategory(category: $0.category.viewContext,
                                                post: $0.viewContext) }
            .flatMap {
                let context = Context(title: "myPage - Blog", items: $0)
                return req.view.render("Blog/Frontend/Blog", context)
            }
    }

    func postView(req: Request) throws -> EventLoopFuture<Response> {
        struct Context: Encodable {
            struct PostWithCategory: Encodable {
                var category: BlogCategoryModel.ViewContext
                var post: BlogPostModel.ViewContext
            }
            let title: String
            let item: PostWithCategory
        }
        
        let slug = req.url.path.trimmingCharacters(in: .init(charactersIn: "/"))
        
        return BlogPostModel.query(on: req.db)
            .filter(\.$slug == slug)
            .with(\.$category)
            .first()
            .flatMap { post in
                guard let post = post else {
                    return req.eventLoop.future(req.redirect(to: "/"))
                }
                let item = Context.PostWithCategory(category: post.category.viewContext,
                                                    post: post.viewContext)
                let context = Context(title: "myPage - \("post.title")", item: item)
                return req.view.render("Blog/Frontend/Post", context).encodeResponse(for: req)
            }
    }
}
