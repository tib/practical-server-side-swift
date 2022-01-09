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

        let list = try await BlogPostApiController().listOutput(req, posts)
        
        let ctx = BlogPostsContext(icon: "🔥",
                                   title: "Blog",
                                   message: "Hot news and stories about everything.",
                                   posts: list)

        return req.templates.renderHtml(BlogPostsTemplate(ctx))
    }

    func postView(req: Request) async throws -> Response? {
        let slug = req.url.path.trimmingCharacters(in: .init(charactersIn: "/"))
        guard
            let post = try await BlogPostModel
                .query(on: req.db)
                .filter(\.$slug == slug)
                .first()
        else {
            return nil
        }
        let model = try await BlogPostApiController().detailOutput(req, post)
        let context = BlogPostContext(post: model)
        return req.templates.renderHtml(BlogPostTemplate(context))
    }
}
