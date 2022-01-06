//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

protocol ApiListController: ListController {
    associatedtype ListObject: Content

    func listOutput(_ req: Request, _ models: [DatabaseModel]) async throws -> [ListObject]
    func listApi(_ req: Request) async throws -> [ListObject]
    func setupListRoutes(_ routes: RoutesBuilder)
}

extension ApiListController {
    
    func listApi(_ req: Request) async throws -> [ListObject] {
        let models = try await DatabaseModel.query(on: req.db).all()
        return try await listOutput(req, models)
    }
    
    func setupListRoutes(_ routes: RoutesBuilder) {
        let baseRoutes = getBaseRoutes(routes)
        baseRoutes.get(use: listApi)
    }
}

