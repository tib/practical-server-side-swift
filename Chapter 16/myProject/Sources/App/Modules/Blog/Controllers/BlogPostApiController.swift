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
    typealias ApiModel = Blog.Post
    typealias DatabaseModel = BlogPostModel

    @AsyncValidatorBuilder
    func validators(optional: Bool) -> [AsyncValidator] {
        KeyedContentValidator<String>.required("title", optional: optional)
        KeyedContentValidator<String>.required("slug", optional: optional)
        KeyedContentValidator<String>.required("image", optional: optional)
        KeyedContentValidator<String>.required("excerpt", optional: optional)
        KeyedContentValidator<String>.required("content", optional: optional)
        KeyedContentValidator<UUID>.required("categoryId", optional: optional)
        KeyedContentValidator<UUID>("categoryId", "Invalid or missing category", optional: optional) { value, req in
            try await BlogCategoryModel.find(value, on: req.db) != nil
        }
    }

    func listOutput(_ req: Request, _ models: [DatabaseModel]) async throws -> [Blog.Post.List] {
        models.map { model in
            .init(id: model.id!,
                  title: model.title,
                  slug: model.slug,
                  image: model.imageKey,
                  excerpt: model.excerpt,
                  date: model.date)
        }
    }
    
    func detailOutput(_ req: Request, _ model: DatabaseModel) async throws -> Blog.Post.Detail {
        guard
            let categoryModel = try await BlogCategoryModel.find(model.$category.id, on: req.db),
            let category = try await BlogCategoryApiController().listOutput(req, [categoryModel]).first
        else {
            throw Abort(.internalServerError)
        }
        return .init(id: model.id!,
              title: model.title,
              slug: model.slug,
              image: model.imageKey,
              excerpt: model.excerpt,
              date: model.date,
              category: category,
              content: model.content)
    }
    
    func createInput(_ req: Request, _ model: DatabaseModel, _ input: Blog.Post.Create) async throws {
        model.title = input.title
        model.slug = input.slug
        model.imageKey = input.image
        model.excerpt = input.excerpt
        model.date = input.date
        model.content = input.content
        model.$category.id = input.categoryId
    }
    
    func updateInput(_ req: Request, _ model: DatabaseModel, _ input: Blog.Post.Update) async throws {
        model.title = input.title
        model.slug = input.slug
        model.imageKey = input.image
        model.excerpt = input.excerpt
        model.date = input.date
        model.content = input.content
        model.$category.id = input.categoryId
    }

    func patchInput(_ req: Request, _ model: DatabaseModel, _ input: Blog.Post.Patch) async throws {
        model.title = input.title ?? model.title
        model.slug = input.slug ?? model.slug
        model.imageKey = input.image ?? model.imageKey
        model.excerpt = input.excerpt ?? model.excerpt
        model.date = input.date ?? model.date
        model.content = input.content ?? model.content
        model.$category.id = input.categoryId ?? model.$category.id
    }
}
