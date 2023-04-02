import Vapor

public protocol ApiDeleteController: DeleteController {
    
    func deleteApi(
        _ req: Request
    ) async throws -> HTTPStatus
    
    func setupDeleteRoutes(
        _ routes: RoutesBuilder
    )
}

public extension ApiDeleteController {
    
    func deleteApi(
        _ req: Request
    ) async throws -> HTTPStatus {
        let model = try await findBy(identifier(req), on: req.db)
        try await delete(req, model)
        return .noContent
    }
    
    func setupDeleteRoutes(
        _ routes: RoutesBuilder
    ) {
        let baseRoutes = getBaseRoutes(routes)
        let existingModelRoutes = baseRoutes
            .grouped(ApiModel.pathIdComponent)
        
        existingModelRoutes.delete(use: deleteApi)
    }
}
