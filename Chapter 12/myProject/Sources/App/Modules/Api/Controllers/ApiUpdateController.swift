//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

public protocol ApiUpdateController: UpdateController {
    associatedtype UpdateObject: Decodable
    
    func updateInput(_ req: Request, _ model: DatabaseModel, _ input: UpdateObject) async throws
    func updateApi(_ req: Request) async throws -> Response
    func updateResponse(_ req: Request, _ model: DatabaseModel) async throws -> Response
}

public extension ApiUpdateController {

    func updateApi(_ req: Request) async throws -> Response {
        let model = try await findBy(identifier(req), on: req.db)
        let input = try req.content.decode(UpdateObject.self)
        try await updateInput(req, model, input)
        try await model.update(on: req.db)
        return try await updateResponse(req, model)
    }
}
