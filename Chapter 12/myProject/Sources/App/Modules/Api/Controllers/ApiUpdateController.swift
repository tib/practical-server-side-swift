import Vapor

public protocol ApiUpdateController: UpdateController {
    associatedtype UpdateObject: Decodable
    
    func updateInput(
        _ req: Request,
        _ model: DatabaseModel,
        _ input: UpdateObject
    ) async throws
    
    func updateApi(
        _ req: Request
    ) async throws -> Response
    
    func updateResponse(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws -> Response
    
    func setupUpdateRoutes(
        _ routes: RoutesBuilder
    )
}

public extension ApiUpdateController {
    
    func updateApi(
        _ req: Request
    ) async throws -> Response {
        let model = try await findBy(identifier(req), on: req.db)
        let input = try req.content.decode(UpdateObject.self)
        try await updateInput(req, model, input)
        try await model.update(on: req.db)
        return try await updateResponse(req, model)
    }
    
    func setupUpdateRoutes(
        _ routes: RoutesBuilder
    ) {
        let baseRoutes = getBaseRoutes(routes)
        let existingModelRoutes = baseRoutes
            .grouped(ApiModel.pathIdComponent)
        
        existingModelRoutes.post(use: updateApi)
    }
}
