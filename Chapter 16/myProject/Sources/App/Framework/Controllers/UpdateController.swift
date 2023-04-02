import Vapor

public protocol UpdateController: ModelController {
    
    func update(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
    
    func beforeUpdate(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
    
    func afterUpdate(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
    
}

public extension UpdateController {
    
    func update(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {
        try await beforeUpdate(req, model)
        try await model.update(on: req.db)
        try await afterUpdate(req, model)
    }
    func beforeUpdate(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {}
    
    func afterUpdate(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {}
}
