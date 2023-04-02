import Vapor

protocol CreateController: ModelController {
    
    func create(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
    
    func beforeCreate(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
    
    func afterCreate(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws
}

extension CreateController {
    
    func create(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {
        try await beforeCreate(req, model)
        try await model.create(on: req.db)
        try await afterCreate(req, model)
    }
    
    func beforeCreate(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {}
    
    func afterCreate(
        _ req: Request,
        _ model: DatabaseModel
    ) async throws {}

}
