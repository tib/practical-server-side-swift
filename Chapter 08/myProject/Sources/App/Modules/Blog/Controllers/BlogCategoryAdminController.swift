import Vapor
import Fluent

struct BlogCategoryAdminController: ListController, CreateController, UpdateController, DeleteController {

    typealias Model = BlogCategoryModel
    typealias CreateForm = BlogCategoryEditForm
    typealias UpdateForm = BlogCategoryEditForm

    func listTable(_ models: [Model]) -> Table {
        Table(columns: ["title"], rows: models.map { model in
            TableRow(id: model.id!.uuidString, cells: [TableCell(model.title)])
        })
    }
}
