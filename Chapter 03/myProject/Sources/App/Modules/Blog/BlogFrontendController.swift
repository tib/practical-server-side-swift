import Vapor

struct BlogFrontendController {

    func blogView(req: Request) throws -> EventLoopFuture<View> {
        struct Context: Encodable {
            let title: String
            let posts: [BlogPost]
        }
        let posts = BlogRepository().publishedPosts()
        let context = Context(title: "myPage - Blog", posts: posts)
        return req.view.render("blog", context)
    }
    
    func postView(req: Request) throws -> EventLoopFuture<Response> {
        let posts = BlogRepository().publishedPosts()
        let slug = req.url.path.trimmingCharacters(in: .init(charactersIn: "/"))
        guard let post = posts.first(where: { $0.slug == slug }) else {
            return req.eventLoop.future(req.redirect(to: "/"))
        }
                
        struct Context: Encodable {
            let title: String
            let post: BlogPost
        }
        let context = Context(title: "myPage - \(post.title)", post: post)
        return req.view.render("post", context).encodeResponse(for: req)
    }
}
 
