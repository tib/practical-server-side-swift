//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 04..
//

import Vapor
import Fluent

struct BlogCategoryAdminController: AdminListController {

    typealias DatabaseModel = BlogCategoryModel

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
}

