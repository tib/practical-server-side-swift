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
    
    private func renderEditForm(_ req: Request,
                                _ title: String,
                                _ form: BlogPostEditForm) -> Response {
        let template = BlogPostAdminEditTemplate(.init(title: title, form: form.render(req: req)))
        return req.templates.renderHtml(template)
    }
    
    func createView(_ req: Request) async throws -> Response {
        let model = BlogPostModel()
        let form = BlogPostEditForm(model)
        try await form.load(req: req)
        return renderEditForm(req, "Create post", form)
    }

    func createAction(_ req: Request) async throws -> Response {
        let model = BlogPostModel()
        let form = BlogPostEditForm(model)
        try await form.load(req: req)
        try await form.process(req: req)
        let isValid = try await form.validate(req: req)
        guard isValid else {
            return renderEditForm(req, "Create post", form)
        }
        try await form.write(req: req)
        try await model.create(on: req.db)
        try await form.save(req: req)
        return req.redirect(to: "/admin/blog/posts/\(model.id!.uuidString)/")
    }
    
    func updateView(_ req: Request) async throws -> Response {
        let model = try await find(req)
        let form = BlogPostEditForm(model)
        try await form.load(req: req)
        try await form.read(req: req)
        return renderEditForm(req, "Update post", form)
    }

    func updateAction(_ req: Request) async throws -> Response {
        let model = try await find(req)
        let form = BlogPostEditForm(model)
        try await form.load(req: req)
        try await form.process(req: req)
        let isValid = try await form.validate(req: req)
        guard isValid else {
            return renderEditForm(req, "Update post", form)
        }
        try await form.write(req: req)
        try await model.update(on: req.db)
        try await form.save(req: req)
        return req.redirect(to: "/admin/blog/posts/\(model.id!.uuidString)/update/")
    }
    
    func deleteView(_ req: Request) async throws -> Response {
        let model = try await find(req)
        
        let template = BlogPostAdminDeleteTemplate(.init(title: "Delete post",
                                                         name: model.title,
                                                         type: "post"))
        
        return req.templates.renderHtml(template)
    }

    func deleteAction(_ req: Request) async throws -> Response {
        let model = try await find(req)
        try await req.fs.delete(key: model.imageKey)
        try await model.delete(on: req.db)
        return req.redirect(to: "/admin/blog/posts/")
    }
}

