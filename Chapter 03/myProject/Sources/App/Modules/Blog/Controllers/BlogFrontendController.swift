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

    func blogView(req: Request) throws -> Response {
        let ctx = BlogPostsContext(title: "myPage - Blog", posts: posts)
        return req.html.render(BlogPostsTemplate(req, context: ctx))
    }

    func postView(req: Request) throws -> Response {
        let slug = req.url.path.trimmingCharacters(in: .init(charactersIn: "/"))
        guard let post = posts.first(where: { $0.slug == slug }) else {
            return req.redirect(to: "/")
        }
        let ctx = BlogPostContext(title: "myPage - \(post.title)", post: post)
        return req.html.render(BlogPostTemplate(req, context: ctx))
    }
}
