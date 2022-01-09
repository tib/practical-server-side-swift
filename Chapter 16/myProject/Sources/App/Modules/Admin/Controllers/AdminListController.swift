//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 04..
//

import Vapor

protocol AdminListController: ListController {

    func listView(_ req: Request) async throws -> Response
    
    func listColumns() -> [ColumnContext]
    func listCells(for model: DatabaseModel) -> [CellContext]
    func listNavigation(_ req: Request) -> [LinkContext]
    func listBreadcrumbs(_ req: Request) -> [LinkContext]
    func listContext(_ req: Request, _ list: [DatabaseModel]) -> AdminListPageContext
    func listTemplate(_ req: Request, _ list: [DatabaseModel]) -> TemplateRepresentable
    func setupListRoutes(_ routes: RoutesBuilder)
}

extension AdminListController {


    func listView(_ req: Request) async throws -> Response {
        let list = try await list(req)
        let template = listTemplate(req, list)
        return req.templates.renderHtml(template)
    }
    
    func listNavigation(_ req: Request) -> [LinkContext] {
        [
            LinkContext(label: "Create",path: "create")
        ]
    }
    
    func listBreadcrumbs(_ req: Request) -> [LinkContext] {
        [
            LinkContext(label: DatabaseModel.Module.identifier.capitalized, dropLast: 1)
        ]
    }
    
    func listContext(_ req: Request, _ list: [DatabaseModel]) -> AdminListPageContext {
        let rows = list.map {
            RowContext(id: $0.id!.uuidString, cells: listCells(for: $0))
        }
        let table = TableContext(columns: listColumns(), rows: rows, actions: [
            LinkContext(label: "Update", path: "update"),
            LinkContext(label: "Delete", path: "delete")
        ])
        return .init(title: "List",
                     table: table,
                     navigation: listNavigation(req),
                     breadcrumbs: listBreadcrumbs(req))
    }

    func listTemplate(_ req: Request, _ list: [DatabaseModel]) -> TemplateRepresentable {
        AdminListPageTemplate(listContext(req, list))
    }
    
    func setupListRoutes(_ routes: RoutesBuilder) {
        let baseRoutes = getBaseRoutes(routes)
        
        baseRoutes.get(use: listView)
    }
}
