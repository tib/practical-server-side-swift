//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 04..
//

import Vapor
import Fluent

public struct Name {
   
    let singular: String
    let plural: String
    
    internal init(singular: String, plural: String? = nil) {
        self.singular = singular
        self.plural = plural ?? singular + "s"
    }
}

public protocol ModelController {
    associatedtype DatabaseModel: DatabaseModelInterface
    
    var modelName: Name { get }
    var parameterId: String { get }
    func identifier(_ req: Request) throws -> UUID
    func findBy(_ id: UUID, on: Database) async throws -> DatabaseModel
}

extension ModelController {
    

    func identifier(_ req: Request) throws -> UUID {
        guard
            let id = req.parameters.get(parameterId),
            let uuid = UUID(uuidString: id)
        else {
            throw Abort(.badRequest)
        }
        return uuid
    }

    func findBy(_ id: UUID, on db: Database) async throws -> DatabaseModel {
        guard let model = try await DatabaseModel.find(id, on: db) else {
            throw Abort(.notFound)
        }
        return model
    }
}

