//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor
import Fluent

struct BlogPostAdminController {
    
    func find(_ req: Request) async throws -> BlogPostModel {
        guard
            let id = req.parameters.get("postId"),
            let uuid = UUID(uuidString: id),
            let post = try await BlogPostModel
                .query(on: req.db)
                .filter(\.$id == uuid)
                .with(\.$category)
                .first()
        else {
            throw Abort(.notFound)
        }
        return post
    }
    
    func listView(_ req: Request) async throws -> Response {
        let posts = try await BlogPostModel.query(on: req.db).all()
        let api = BlogPostApiController()
        let list = posts.map { api.mapList($0) }
        let template = BlogPostAdminListTemplate(.init(title: "Posts", list: list))
        return req.templates.renderHtml(template)
    }

    func detailView(_ req: Request) async throws -> Response {
        let post = try await find(req)
        let detail = BlogPostApiController().mapDetail(post)
        let template = BlogPostAdminDetailTemplate(.init(title: "Post details", detail: detail))
        return req.templates.renderHtml(template)
    }
    
    private func renderEditForm(_ req: Request, _ form: BlogPostEditForm) -> Response {
        let template = BlogPostAdminEditTemplate(.init(title: "Edit post", form: form.render(req: req)))
        return req.templates.renderHtml(template)
    }
    
    func createView(_ req: Request) async throws -> Response {
        renderEditForm(req, .init(.init()))
    }

    func createAction(_ req: Request) async throws -> Response {
        let form = BlogPostEditForm(.init())
//        try await form.process(req: req)
//        if try await form.validate(req: req) {
//
//        }
        return renderEditForm(req, form)
    }
}

