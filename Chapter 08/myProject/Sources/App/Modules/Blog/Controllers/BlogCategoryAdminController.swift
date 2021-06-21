import Vapor
import Fluent
import Tau

struct BlogCategoryAdminController: ListController {
    typealias Model = BlogCategoryModel
//    typealias CreateForm = BlogCategoryEditForm
    
    func listContext(req: Request, table: Table) -> ListContext {
        .init(title: "Categories", table: table)
    }

    func listTable(_ models: [Model]) -> Table {
        Table(columns: ["title"], rows: models.map { model in
            TableRow(id: model.id!.uuidString, cells: [TableCell(model.title)])
        })
    }
}
