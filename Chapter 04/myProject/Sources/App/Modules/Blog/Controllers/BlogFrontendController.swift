//
//  BlogFrontendController.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor

struct BlogFrontendController {
    
    var posts: [BlogPost] = {
        (0...9).map { index in
            BlogPost(title: "Sample post #\(index)",
                     slug: "sample-post-\(index)",
                     image: "/img/posts/\(String(format: "%02d", index + 1)).jpg",
                     excerpt: "Lorem ipsum",
                     date: Date().addingTimeInterval(-Double.random(in: 0...(86400 * 60))),
                     category: Bool.random() ? "Sample category" : nil,
                     content: "Lorem ipsum dolor sit amet.")
        }.sorted() { $0.date > $1.date }
    }()

    func blogView(req: Request) throws -> Response {
        let ctx = BlogPostsContext(icon: "🔥",
                                   title: "Blog",
                                   message: "Hot news and stories about everything.",
                                   posts: posts)
        return req.templates.renderHtml(BlogPostsTemplate(ctx))
    }

    func postView(req: Request) throws -> Response {
        let slug = req.url.path.trimmingCharacters(in: .init(charactersIn: "/"))
        guard let post = posts.first(where: { $0.slug == slug }) else {
            return req.redirect(to: "/")
        }
        let ctx = BlogPostContext(post: post)
        return req.templates.renderHtml(BlogPostTemplate(ctx))
    }
}
