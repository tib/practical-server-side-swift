import Vapor
import Fluent
import ContentApi

struct BlogPostApiController: ApiController {
    typealias Model = BlogPostModel
    
    func setValidCategory(req: Request, model: Model, categoryId: String) -> EventLoopFuture<Model> {
        guard let uuid = UUID(uuidString: categoryId) else {
            return req.eventLoop.future(error: Abort(.badRequest))
        }
        return BlogCategoryModel.find(uuid, on: req.db)
            .unwrap(or: Abort(.badRequest))
            .map { category  in
                model.$category.id = category.id!
                return model
            }
    }
    
    func beforeCreate(req: Request, model: Model, content: Model.CreateContent) -> EventLoopFuture<Model> {
        self.setValidCategory(req: req, model: model, categoryId: content.categoryId)
    }

    func beforeUpdate(req: Request, model: Model, content: Model.UpdateContent) -> EventLoopFuture<Model> {
        self.setValidCategory(req: req, model: model, categoryId: content.categoryId)
    }
}
