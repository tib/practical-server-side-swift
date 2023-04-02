import Vapor

extension Blog.Post.List: Content {}
extension Blog.Post.Detail: Content {}

struct BlogPostApiController: ApiController {
    typealias ApiModel = Blog.Post
    typealias DatabaseModel = BlogPostModel
    
    func listOutput(
        _ req: Request,
        _ models: [DatabaseModel]
    ) async throws -> [Blog.Post.List] {
        models.map { model in
                .init(
                    id: model.id!,
                    title: model.title,
                    slug: model.slug,
                    image: model.imageKey,
                    excerpt: model.excerpt,
                    date: model.date
                )
        }
    }
    
    func detailOutput(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws -> Blog.Post.Detail {
        .init(
            id: model.id!,
            title: model.title,
            slug: model.slug,
            image: model.imageKey,
            excerpt: model.excerpt,
            date: model.date,
            category: .init(
                id: model.category.id!,
                title: model.category.title
            ),
            content: model.content
        )
    }
    
    func createInput(
        _ req: Request,
        _ model: DatabaseModel,
        _ input: Blog.Post.Create
    ) async throws {
        model.title = input.title
        model.slug = input.slug
        model.imageKey = input.image
        model.excerpt = input.excerpt
        model.date = input.date
        model.content = input.content
    }
    
    func updateInput(
        _ req: Request,
        _ model: DatabaseModel,
        _ input: Blog.Post.Update
    ) async throws {
        model.title = input.title
        model.slug = input.slug
        model.imageKey = input.image
        model.excerpt = input.excerpt
        model.date = input.date
        model.content = input.content
    }
    
    func patchInput(
        _ req: Request,
        _ model: DatabaseModel,
        _ input: Blog.Post.Patch
    ) async throws {
        model.title = input.title ?? model.title
        model.slug = input.slug ?? model.slug
        model.imageKey = input.image ?? model.imageKey
        model.excerpt = input.excerpt ?? model.excerpt
        model.date = input.date ?? model.date
        model.content = input.content ?? model.content
    }
}
