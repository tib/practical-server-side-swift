//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

protocol ApiUpdateController: UpdateController {
    associatedtype UpdateObject: Decodable
    
    func updateValidators() -> [AsyncValidator]
    func updateInput(_ req: Request, _ model: DatabaseModel, _ input: UpdateObject) async throws
    func updateApi(_ req: Request) async throws -> Response
    func updateResponse(_ req: Request, _ model: DatabaseModel) async throws -> Response
    func setupUpdateRoutes(_ routes: RoutesBuilder)
}

extension ApiUpdateController {

    func updateValidators() -> [AsyncValidator] {
        []
    }
    
    func updateApi(_ req: Request) async throws -> Response {
        try await RequestValidator(updateValidators()).validate(req)
        let model = try await findBy(identifier(req), on: req.db)
        let input = try req.content.decode(UpdateObject.self)
        try await updateInput(req, model, input)
        try await update(req, model)
        return try await updateResponse(req, model)
    }
    
    func setupUpdateRoutes(_ routes: RoutesBuilder) {
        let baseRoutes = getBaseRoutes(routes)
        let existingModelRoutes = baseRoutes.grouped(ApiModel.pathIdComponent)
        existingModelRoutes.put(use: updateApi)
    }
}
