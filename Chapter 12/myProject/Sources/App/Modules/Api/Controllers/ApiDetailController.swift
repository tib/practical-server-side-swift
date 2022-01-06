//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

protocol ApiDetailController: DetailController {
    associatedtype DetailObject: Content
    
    func detailOutput(_ req: Request, _ model: DatabaseModel) async throws -> DetailObject
    func detailApi(_ req: Request) async throws -> DetailObject
}

extension ApiDetailController {

    func detailApi(_ req: Request) async throws -> DetailObject {
        let model = try await findBy(identifier(req), on: req.db)
        return try await detailOutput(req, model)
    }
}
