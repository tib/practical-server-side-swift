//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

import Vapor

protocol AdminDetailController: DetailController {
    func detailView(_ req: Request) async throws -> Response
    func detailTemplate(_ req: Request, _ model: DatabaseModel) -> TemplateRepresentable
    
    func detailFields(for model: DatabaseModel) -> [DetailContext]
    func detailContext(_ req: Request, _ model: DatabaseModel) -> AdminDetailPageContext
    func detailBreadcrumbs(_ req: Request, _ model: DatabaseModel) -> [LinkContext]
    func detailNavigation(_ req: Request, _ model: DatabaseModel) -> [LinkContext]
    func setupDetailRoutes(_ routes: RoutesBuilder)
}

extension AdminDetailController {
    
    func detailView(_ req: Request) async throws -> Response {
        let model = try await detail(req)
        return req.templates.renderHtml(detailTemplate(req, model))
    }

    func detailTemplate(_ req: Request, _ model: DatabaseModel) -> TemplateRepresentable {
        AdminDetailPageTemplate(detailContext(req, model))
    }

    func detailContext(_ req: Request, _ model: DatabaseModel) -> AdminDetailPageContext {
        .init(title: "Details",
              fields: detailFields(for: model),
              navigation: detailNavigation(req, model),
              breadcrumbs: detailBreadcrumbs(req, model),
              actions: [
                LinkContext(label: "Delete",
                            path: "/delete/?redirect=" + req.url.path.pathComponents.dropLast().string + "&cancel=" + req.url.path),
              ])
    }

    func detailBreadcrumbs(_ req: Request, _ model: DatabaseModel) -> [LinkContext] {
        [
            LinkContext(label: Self.moduleName.capitalized, dropLast: 2),
            LinkContext(label: Self.modelName.plural.capitalized, dropLast: 1),
        ]
    }

    func detailNavigation(_ req: Request, _ model: DatabaseModel) -> [LinkContext] {
        [
            LinkContext(label: "Update", path: "update"),
        ]
    }
    
    func setupDetailRoutes(_ routes: RoutesBuilder) {
        let baseRoutes = getBaseRoutes(routes)
                
        let existingModelRoutes = baseRoutes.grouped(ApiModel.pathIdComponent)
        
        existingModelRoutes.get(use: detailView)
    }
}
