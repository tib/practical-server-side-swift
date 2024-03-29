import Vapor

protocol ApiController:
    ApiListController,
    ApiDetailController,
    ApiCreateController,
    ApiUpdateController,
    ApiPatchController,
    ApiDeleteController
{
    func setupRoutes(
        _ routes: RoutesBuilder
    )
}

extension ApiController {
    
    func createResponse(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws -> Response {
        try await detailOutput(req, model)
            .encodeResponse(status: .created, for: req)
    }
    
    func updateResponse(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws -> Response {
        try await detailOutput(req, model)
            .encodeResponse(for: req)
    }
    
    func patchResponse(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws -> Response {
        try await detailOutput(req, model)
            .encodeResponse(for: req)
    }
    
    func setupRoutes(
        _ routes: RoutesBuilder
    ) {
        setupListRoutes(routes)
        setupDetailRoutes(routes)
        setupCreateRoutes(routes)
        setupUpdateRoutes(routes)
        setupPatchRoutes(routes)
        setupDeleteRoutes(routes)
    }
}
