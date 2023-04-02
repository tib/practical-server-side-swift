import Vapor
import Fluent

protocol ListController: ModelController {
    
    func list(
        _ req: Request
    ) async throws -> [DatabaseModel]
    
    func beforeList(
        _ req: Request,
        _ queryBuilder: QueryBuilder<DatabaseModel>
    ) async throws -> QueryBuilder<DatabaseModel>
    
    func afterList(
        _ req: Request,
        _ models: [DatabaseModel]
    ) async throws -> [DatabaseModel]
}

extension ListController {
    
    func list(
        _ req: Request
    ) async throws -> [DatabaseModel] {
        try await DatabaseModel
            .query(on: req.db)
            .all()
    }
    
    func beforeList(
        _ req: Request,
        _ queryBuilder: QueryBuilder<DatabaseModel>
    ) async throws -> QueryBuilder<DatabaseModel> {
        queryBuilder
    }
    
    func afterList(
        _ req: Request,
        _ models: [DatabaseModel]
    ) async throws -> [DatabaseModel] {
        models
    }
}
