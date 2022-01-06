//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

public protocol ApiDeleteController: DeleteController {
    
    func deleteApi(_ req: Request) async throws -> HTTPStatus
}

public extension ApiDeleteController {

    func deleteApi(_ req: Request) async throws -> HTTPStatus {
        let model = try await findBy(identifier(req), on: req.db)
        try await model.delete(on: req.db)
        return .noContent
    }
}
