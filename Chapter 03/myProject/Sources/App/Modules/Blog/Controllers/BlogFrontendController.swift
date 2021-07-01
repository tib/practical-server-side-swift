import Vapor
import LoremSwiftum

struct BlogFrontendController {
    
    var posts: [BlogPost] = {
        stride(from: 0, to: 10, by: 1).map { index in
            let title = Lorem.title
            return BlogPost(title: title,
                            slug: title.lowercased().replacingOccurrences(of: " ", with: "-"),
                            image: "/img/posts/\(String(format: "%02d", index + 1)).jpg",
                            excerpt: Lorem.sentence,
                            date: Date().addingTimeInterval(-Double.random(in: 0...(86400 * 60))),
                            category: Bool.random() ? Lorem.word.capitalized : nil,
                            content: Lorem.paragraph)
        }.sorted() { $0.date > $1.date }
    }()

    func blogView(req: Request) throws -> EventLoopFuture<View> {
        struct Context: Codable {
            let title: String
            let posts: [BlogPost]
        }
        let ctx = Context(title: "myPage - Blog", posts: posts)
        return req.view.render("Blog/Posts", ctx)
    }

    func postView(req: Request) throws -> EventLoopFuture<Response> {
        let slug = req.url.path.trimmingCharacters(in: .init(charactersIn: "/"))
        guard let post = posts.first(where: { $0.slug == slug }) else {
            return req.eventLoop.future(req.redirect(to: "/"))
        }
        struct Context: Codable {
            let title: String
            let post: BlogPost
        }
        let ctx = Context(title: "myPage - \(post.title)", post: post)
        return req.view.render("Blog/Post", ctx).encodeResponse(for: req)
    }
}
