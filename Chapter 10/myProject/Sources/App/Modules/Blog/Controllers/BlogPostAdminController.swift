//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor
import Fluent

struct BlogPostAdminController: AdminListController, AdminCreateController, AdminUpdateController, AdminDeleteController {
    typealias DatabaseModel = BlogPostModel

    typealias CreateModelEditor = BlogPostEditor
    typealias UpdateModelEditor = BlogPostEditor
    
    let parameterId: String = "postId"

    func find(_ req: Request) async throws -> DatabaseModel {
        guard
            let post = try await DatabaseModel
                .query(on: req.db)
                .filter(\.$id == identifier(req))
                .with(\.$category)
                .first()
        else {
            throw Abort(.notFound)
        }
        return post
    }

    func listColumns() -> [ColumnContext] {
        [
            .init("image"),
            .init("title"),
        ]
    }
    
    func listCells(for model: DatabaseModel) -> [CellContext] {
        [
            .init(model.imageKey, type: .image),
            .init(model.title, link: .init(label: model.title)),
        ]
    }

    func detailView(_ req: Request) async throws -> Response {
        let post = try await find(req)
        let detail = BlogPostApiController().mapDetail(post)
        let template = BlogPostAdminDetailTemplate(.init(title: "Post details", detail: detail))
        return req.templates.renderHtml(template)
    }
    
    func deleteInfo(_ model: DatabaseModel) -> String {
        model.title
    }
}

