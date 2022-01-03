//
//  BlogFrontendController.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import Fluent

struct BlogFrontendController {
    
    func blogView(req: Request) async throws -> Response {
        let posts = try await BlogPostModel
            .query(on: req.db)
            .sort(\.$date, .descending)
            .all()

        let api = BlogPostApiController()
        let list = posts.map { api.mapList($0) }
        
        let ctx = BlogPostsContext(icon: "🔥",
                                   title: "Blog",
                                   message: "Hot news and stories about everything.",
                                   posts: list)

        return req.templates.renderHtml(BlogPostsTemplate(ctx))
    }

    func postView(req: Request) async throws -> Response {
        let slug = req.url.path.trimmingCharacters(in: .init(charactersIn: "/"))
        guard
            let post = try await BlogPostModel
                .query(on: req.db)
                .filter(\.$slug == slug)
                .with(\.$category)
                .first()
        else {
            return req.redirect(to: "/")
        }
        let ctx = BlogPostContext(post: Blog.Post.Detail(id: post.id!,
                                                         title: post.title,
                                                         slug: post.slug,
                                                         image: post.imageKey,
                                                         excerpt: post.excerpt,
                                                         date: post.date,
                                                         category: .init(id: post.category.id!,
                                                                         title: post.category.title),
                                                         content: post.content))
        return req.templates.renderHtml(BlogPostTemplate(ctx))
    }
}
