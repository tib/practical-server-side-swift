import Vapor

public protocol PatchController: ModelController {
    
    func patch(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
    
    func beforePatch(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
    
    func afterPatch(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
    
}

public extension PatchController {
    
    func patch(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {
        try await beforePatch(req, model)
        try await model.update(on: req.db)
        try await afterPatch(req, model)
    }
    
    func beforePatch(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {}
    
    func afterPatch(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {}
}
