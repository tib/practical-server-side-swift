import Vapor
import Fluent

struct BlogCategoryAdminController: AdminController {
    typealias ApiModel = Blog.Category
    typealias DatabaseModel = BlogCategoryModel
    typealias CreateModelEditor = BlogCategoryEditor
    typealias UpdateModelEditor = BlogCategoryEditor
 
    func listColumns() -> [ColumnContext] {
        [
            .init("title"),
        ]
    }
    
    func listCells(
        for model: DatabaseModel
    ) -> [CellContext] {
        [
            .init(
                model.title,
                link: .init(label: model.title)
            ),
        ]
    }
    
    func detailFields(
        for model: DatabaseModel
    ) -> [DetailContext] {
        [
            .init("title", model.title),
        ]
    }
    
    func deleteInfo(
        _ model: DatabaseModel
    ) -> String {
        model.title
    }
}
