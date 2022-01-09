//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor
import Fluent

protocol ListController: ModelController {

    func list(_ req: Request) async throws -> [DatabaseModel]
    func beforeList(_ req: Request, _ queryBuilder: QueryBuilder<DatabaseModel>) async throws -> QueryBuilder<DatabaseModel>
    func afterList(_ req: Request, _ models: [DatabaseModel]) async throws -> [DatabaseModel]
}

extension ListController {
    
    func beforeList(_ req: Request, _ queryBuilder: QueryBuilder<DatabaseModel>) async throws -> QueryBuilder<DatabaseModel> {
        queryBuilder
    }

    func afterList(_ req: Request, _ models: [DatabaseModel]) async throws -> [DatabaseModel] {
        models
    }

    func list(_ req: Request) async throws -> [DatabaseModel] {
        let queryBuilder = DatabaseModel.query(on: req.db)
        let list = try await beforeList(req, queryBuilder).all()
        return try await afterList(req, list)
    }
}
