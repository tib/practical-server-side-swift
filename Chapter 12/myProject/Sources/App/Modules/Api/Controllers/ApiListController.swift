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
}

extension ApiListController {
    
    func listApi(_ req: Request) async throws -> [ListObject] {
        let models = try await DatabaseModel.query(on: req.db).all()
        return try await listOutput(req, models)
    }
}

