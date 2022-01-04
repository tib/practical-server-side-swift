//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 04..
//

import Vapor

protocol ListController: ModelController {
    func list(_ req: Request) async throws -> [DatabaseModel]
}

extension ListController {

    func list(_ req: Request) async throws -> [DatabaseModel] {
        try await DatabaseModel.query(on: req.db).all()
    }
}
