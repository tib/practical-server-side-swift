import Vapor

public protocol DeleteController: ModelController {
    
    func delete(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
    
    func beforeDelete(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
    
    func afterDelete(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
}

public extension DeleteController {

    func delete(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {
        try await beforeDelete(req, model)
        try await model.delete(on: req.db)
        try await afterDelete(req, model)
    }
    
    func beforeDelete(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {}
    
    func afterDelete(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {}
}
