//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

protocol ApiCreateController: CreateController {
    associatedtype CreateObject: Decodable

    func createInput(_ req: Request, _ model: DatabaseModel, _ input: CreateObject) async throws
    func createApi(_ req: Request) async throws -> Response
    func createResponse(_ req: Request, _ model: DatabaseModel) async throws -> Response
    func setupCreateRoutes(_ routes: RoutesBuilder)
}

extension ApiCreateController {
    
    func createApi(_ req: Request) async throws -> Response {
        let input = try req.content.decode(CreateObject.self)
        let model = DatabaseModel()
        try await createInput(req, model, input)
        try await model.create(on: req.db)
        return try await createResponse(req, model)
    }
    
    func setupCreateRoutes(_ routes: RoutesBuilder) {
        let baseRoutes = getBaseRoutes(routes)
        baseRoutes.post(use: createApi)
    }
}
