import Vapor

extension Blog.Category.List: Content {}
extension Blog.Category.Detail: Content {}

struct BlogCategoryApiController: ApiController {
    typealias ApiModel = Blog.Category
    typealias DatabaseModel = BlogCategoryModel
    
    @AsyncValidatorBuilder
    func validators(
        optional: Bool
    ) -> [AsyncValidator] {
        KeyedContentValidator<String>.required("title", optional: optional)
    }
    
    func listOutput(
        _ req: Request,
        _ models: [BlogCategoryModel]
    ) async throws -> [Blog.Category.List] {
        models.map {
            .init(id: $0.id!, title: $0.title)
        }
    }
    
    func detailOutput(
        _ req: Request,
        _ model: BlogCategoryModel
    ) async throws -> Blog.Category.Detail {
        .init(
            id: model.id!,
            title: model.title
        )
    }
    
    func createInput(
        _ req: Request,
        _ model: BlogCategoryModel,
        _ input: Blog.Category.Create
    ) async throws {
        model.title = input.title
    }
    
    func updateInput(
        _ req: Request,
        _ model: BlogCategoryModel,
        _ input: Blog.Category.Update
    ) async throws {
        model.title = input.title
    }
    
    func patchInput(
        _ req: Request,
        _ model: BlogCategoryModel,
        _ input: Blog.Category.Patch
    ) async throws {
        model.title = input.title ?? model.title
    }
}
