import Vapor
import Fluent

struct BlogPostAdminController: ListController, CreateController, UpdateController, DeleteController {

    typealias Model = BlogPostModel
    typealias CreateForm = BlogPostEditForm
    typealias UpdateForm = BlogPostEditForm
    
    func listTable(_ models: [Model]) -> Table {
        Table(columns: ["image", "title"], rows: models.map { model in
            TableRow(id: model.id!.uuidString, cells: [
                TableCell(type: .image, model.image),
                TableCell(model.title),
            ])
        })
    }
}
