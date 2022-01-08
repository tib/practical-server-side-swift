//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

protocol ApiPatchController: PatchController {
    associatedtype PatchObject: Decodable
    
    func patchValidators() -> [AsyncValidator]
    func patchInput(_ req: Request, _ model: DatabaseModel, _ input: PatchObject) async throws
    func patchApi(_ req: Request) async throws -> Response
    func patchResponse(_ req: Request, _ model: DatabaseModel) async throws -> Response
    func setupPatchRoutes(_ routes: RoutesBuilder)
}

extension ApiPatchController {

    func patchValidators() -> [AsyncValidator] {
        []
    }
    
    func patchApi(_ req: Request) async throws -> Response {
        try await RequestValidator(patchValidators()).validate(req)
        let model = try await findBy(identifier(req), on: req.db)
        let input = try req.content.decode(PatchObject.self)
        try await patchInput(req, model, input)
        try await patch(req, model)
        return try await patchResponse(req, model)
    }
    
    func setupPatchRoutes(_ routes: RoutesBuilder) {
        let baseRoutes = getBaseRoutes(routes)
        let existingModelRoutes = baseRoutes.grouped(ApiModel.pathIdComponent)
        existingModelRoutes.patch(use: patchApi)
    }
}
