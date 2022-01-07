//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor
import Fluent

struct BlogPostAdminController: AdminController {
    typealias ApiModel = Blog.Post
    typealias DatabaseModel = BlogPostModel
    typealias CreateModelEditor = BlogPostEditor
    typealias UpdateModelEditor = BlogPostEditor

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

    func detailFields(for model: DatabaseModel) -> [DetailContext] {
        [
            .init("image", model.imageKey, type: .image),
            .init("title", model.title),
        ]
    }
    
    func deleteInfo(_ model: DatabaseModel) -> String {
        model.title
    }
    
    func beforeDelete(_ req: Request, _ model: BlogPostModel) async throws {
        try await req.fs.delete(key: model.imageKey)
    }
}

