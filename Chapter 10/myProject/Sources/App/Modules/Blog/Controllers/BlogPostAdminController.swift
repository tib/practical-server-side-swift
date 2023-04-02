import Vapor
import Fluent

struct BlogPostAdminController:
    AdminListController,
    AdminDetailController,
    AdminCreateController,
    AdminUpdateController,
    AdminDeleteController
{
    typealias DatabaseModel = BlogPostModel
    typealias CreateModelEditor = BlogPostEditor
    typealias UpdateModelEditor = BlogPostEditor
    
    let modelName: Name = .init(singular: "post")
    let parameterId: String = "postId"
    
    func listColumns() -> [ColumnContext] {
        [
            .init("image"),
            .init("title"),
        ]
    }
    
    func listCells(for model: DatabaseModel) -> [CellContext] {
        [
            .init(model.imageKey, type: .image),
            .init(model.title, link: .init(label: model.title)),
        ]
    }
    
    func detailFields(for model: DatabaseModel) -> [DetailContext] {
        [
            .init("image", model.imageKey, type: .image),
            .init("title", model.title),
        ]
    }
    
    func deleteInfo(
        _ model: DatabaseModel
    ) -> String {
        model.title
    }
}
