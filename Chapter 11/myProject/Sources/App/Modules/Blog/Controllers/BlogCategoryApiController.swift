import Vapor

extension Blog.Category.List: Content {}
extension Blog.Category.Detail: Content {}

struct BlogCategoryApiController: ModelController {
    typealias DatabaseModel = BlogCategoryModel
    
    var modelName: Name = .init(
        singular: "category",
        plural: "categories"
    )
    var parameterId: String = "categoryId"
    
    func listOutput(
        _ req: Request,
        _ models: [BlogCategoryModel]
    ) async throws -> [Blog.Category.List] {
        models.map {
            .init(id: $0.id!, title: $0.title)
        }
    }
    
    func listApi(
        _ req: Request
    ) async throws -> [Blog.Category.List] {
        let models = try await BlogCategoryModel
            .query(on: req.db)
            .all()
        return try await listOutput(req, models)
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
    
    func detailApi(
        _ req: Request
    ) async throws -> Blog.Category.Detail {
        let model = try await findBy(identifier(req), on: req.db)
        return try await detailOutput(req, model)
    }
    
    func createInput(
        _ req: Request,
        _ model: BlogCategoryModel,
        _ input: Blog.Category.Create
    ) async throws {
        model.title = input.title
    }
    
    func createApi(
        _ req: Request
    ) async throws -> Response {
        let input = try req.content.decode(Blog.Category.Create.self)
        let model = DatabaseModel()
        try await createInput(req, model, input)
        try await model.create(on: req.db)
        return try await detailOutput(req, model)
            .encodeResponse(status: .created, for: req)
    }
    
    func updateInput(
        _ req: Request,
        _ model: BlogCategoryModel,
        _ input: Blog.Category.Update
    ) async throws {
        model.title = input.title
    }
    
    func updateApi(
        _ req: Request
    ) async throws -> Response {
        let model = try await findBy(identifier(req), on: req.db)
        let input = try req.content.decode(Blog.Category.Update.self)
        try await updateInput(req, model, input)
        try await model.update(on: req.db)
        return try await detailOutput(req, model)
            .encodeResponse(for: req)
    }
    
    func patchInput(
        _ req: Request,
        _ model: BlogCategoryModel,
        _ input: Blog.Category.Patch
    ) async throws {
        model.title = input.title ?? model.title
    }
    
    func patchApi(
        _ req: Request
    ) async throws -> Response {
        let model = try await findBy(identifier(req), on: req.db)
        let input = try req.content.decode(Blog.Category.Patch.self)
        try await patchInput(req, model, input)
        try await model.update(on: req.db)
        return try await detailOutput(req, model)
            .encodeResponse(for: req)
    }
    
    func deleteApi(
        _ req: Request
    ) async throws -> HTTPStatus {
        let model = try await findBy(identifier(req), on: req.db)
        try await model.delete(on: req.db)
        return .noContent
    }
}
