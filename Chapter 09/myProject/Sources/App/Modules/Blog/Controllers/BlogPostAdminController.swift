//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor

struct BlogPostAdminController {
    
    func listView(_ req: Request) async throws -> Response {
        let posts = try await BlogPostModel.query(on: req.db).all()
        let api = BlogPostApiController()
        let list = posts.map { api.mapList($0) }
        let template = BlogPostAdminListTemplate(.init(title: "Posts", list: list))
        return req.templates.renderHtml(template)
    }
}

