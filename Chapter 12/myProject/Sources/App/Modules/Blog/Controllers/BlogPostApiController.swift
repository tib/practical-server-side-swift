//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor

extension Blog.Post.List: Content {}
extension Blog.Post.Detail: Content {}

struct BlogPostApiController: ApiController {
    typealias DatabaseModel = BlogPostModel
    
    var modelName: Name = .init(singular: "Post", plural: "categories")
    var parameterId: String = "PostId"

    func listOutput(_ req: Request, _ models: [BlogPostModel]) async throws -> [Blog.Post.List] {
        models.map { model in
            .init(id: model.id!,
                  title: model.title,
                  slug: model.slug,
                  image: model.imageKey,
                  excerpt: model.excerpt,
                  date: model.date)
        }
    }
    
    func detailOutput(_ req: Request, _ model: BlogPostModel) async throws -> Blog.Post.Detail {
        .init(id: model.id!,
              title: model.title,
              slug: model.slug,
              image: model.imageKey,
              excerpt: model.excerpt,
              date: model.date,
              category: .init(id: model.category.id!,
                          title: model.category.title),
              content: model.content)
    }
    
    func createInput(_ req: Request, _ model: BlogPostModel, _ input: Blog.Post.Create) async throws {
        model.title = input.title
    }
    
    func updateInput(_ req: Request, _ model: BlogPostModel, _ input: Blog.Post.Update) async throws {
        model.title = input.title
    }

    func patchInput(_ req: Request, _ model: BlogPostModel, _ input: Blog.Post.Patch) async throws {
        model.title = input.title ?? model.title
    }
}
