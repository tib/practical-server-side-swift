import Vapor

public protocol ApiPatchController: PatchController {
    associatedtype PatchObject: Decodable
    
    func patchInput(
        _ req: Request,
        _ model: DatabaseModel,
        _ input: PatchObject
    ) async throws
    
    func patchApi(
        _ req: Request
    ) async throws -> Response
    
    func patchResponse(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws -> Response
    
    func setupPatchRoutes(
        _ routes: RoutesBuilder
    )
}

public extension ApiPatchController {
    
    func patchApi(
        _ req: Request
    ) async throws -> Response {
        let model = try await findBy(identifier(req), on: req.db)
        let input = try req.content.decode(PatchObject.self)
        try await patchInput(req, model, input)
        try await model.update(on: req.db)
        return try await patchResponse(req, model)
    }
    
    func setupPatchRoutes(
        _ routes: RoutesBuilder
    ) {
        let baseRoutes = getBaseRoutes(routes)
        let existingModelRoutes = baseRoutes
            .grouped(ApiModel.pathIdComponent)
        
        existingModelRoutes.patch(use: patchApi)
    }
}
