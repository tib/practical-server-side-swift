//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

protocol ApiPatchController: PatchController {
    associatedtype PatchObject: Decodable
    
    func patchInput(_ req: Request, _ model: DatabaseModel, _ input: PatchObject) async throws
    func patchApi(_ req: Request) async throws -> Response
    func patchResponse(_ req: Request, _ model: DatabaseModel) async throws -> Response
}

extension ApiPatchController {

    func patchApi(_ req: Request) async throws -> Response {
        let model = try await findBy(identifier(req), on: req.db)
        let input = try req.content.decode(PatchObject.self)
        try await patchInput(req, model, input)
        try await model.update(on: req.db)
        return try await patchResponse(req, model)
    }
}
