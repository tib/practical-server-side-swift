//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

protocol DeleteController: ModelController {
    func beforeDelete(_ req: Request, _ model: DatabaseModel) async throws
    func afterDelete(_ req: Request, _ model: DatabaseModel) async throws
    func delete(_ req: Request, _ model: DatabaseModel) async throws
}

extension DeleteController {
    
    func beforeDelete(_ req: Request, _ model: DatabaseModel) async throws {}
    func afterDelete(_ req: Request, _ model: DatabaseModel) async throws {}
    
    func delete(_ req: Request, _ model: DatabaseModel) async throws {
        try await beforeDelete(req, model)
        try await model.delete(on: req.db)
        try await afterDelete(req, model)
    }
}
