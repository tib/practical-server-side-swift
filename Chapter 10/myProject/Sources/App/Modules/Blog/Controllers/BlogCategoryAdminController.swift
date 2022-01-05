//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 04..
//

import Vapor
import Fluent

struct BlogCategoryAdminController: AdminListController, AdminCreateController, AdminUpdateController, AdminDeleteController {
    
    
    typealias DatabaseModel = BlogCategoryModel
    typealias CreateModelEditor = BlogCategoryEditor
    typealias UpdateModelEditor = BlogCategoryEditor
    
    let parameterId: String = "categoryId"

    func listColumns() -> [ColumnContext] {
        [
            .init("title"),
        ]
    }
    
    func listCells(for model: DatabaseModel) -> [CellContext] {
        [
            .init(model.title, link: .init(label: model.title)),
        ]
    }
    
    func deleteInfo(_ model: DatabaseModel) -> String {
        model.title
    }
}

