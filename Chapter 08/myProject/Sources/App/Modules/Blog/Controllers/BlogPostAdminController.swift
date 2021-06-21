import Vapor
import Fluent
import Tau

struct BlogPostAdminController: ListController, CreateController, UpdateController, DeleteController {

    typealias Model = BlogPostModel
    typealias CreateForm = BlogPostEditForm

    func listContext(req: Request, table: Table) -> ListContext {
        .init(title: "Posts", table: table)
    }
    
    func listTable(_ models: [Model]) -> Table {
        Table(columns: ["image", "title"], rows: models.map { model in
            TableRow(id: model.id!.uuidString, cells: [
                TableCell(type: .image, model.image),
                TableCell(model.title),
            ])
        })
    }
}
