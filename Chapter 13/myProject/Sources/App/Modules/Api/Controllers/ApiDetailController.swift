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
    func setupDetailRoutes(_ routes: RoutesBuilder)
}

extension ApiDetailController {

    func detailApi(_ req: Request) async throws -> DetailObject {
        let model = try await detail(req)
        return try await detailOutput(req, model)
    }
    
    func setupDetailRoutes(_ routes: RoutesBuilder) {
        let baseRoutes = getBaseRoutes(routes)
        let existingModelRoutes = baseRoutes.grouped(ApiModel.pathIdComponent)
        existingModelRoutes.get(use: detailApi)
    }
}
