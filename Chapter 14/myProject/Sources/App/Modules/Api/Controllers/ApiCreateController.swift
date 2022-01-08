//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

protocol ApiCreateController: CreateController {
    associatedtype CreateObject: Decodable

    func createValidators() -> [AsyncValidator]
    func createInput(_ req: Request, _ model: DatabaseModel, _ input: CreateObject) async throws
    func createApi(_ req: Request) async throws -> Response
    func createResponse(_ req: Request, _ model: DatabaseModel) async throws -> Response
    func setupCreateRoutes(_ routes: RoutesBuilder)
}

extension ApiCreateController {
    
    func createValidators() -> [AsyncValidator] {
        []
    }

    func createApi(_ req: Request) async throws -> Response {
        try await RequestValidator(createValidators()).validate(req)
        let input = try req.content.decode(CreateObject.self)
        let model = DatabaseModel()
        try await createInput(req, model, input)
        try await create(req, model)
        return try await createResponse(req, model)
    }
    
    func setupCreateRoutes(_ routes: RoutesBuilder) {
        let baseRoutes = getBaseRoutes(routes)
        baseRoutes.post(use: createApi)
    }
}
