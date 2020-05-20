import Vapor
import Fluent

struct BlogPostAdminController {
    
    func listView(req: Request) throws -> EventLoopFuture<View> {
        struct Context<T: Encodable>: Encodable {
            let list: [T]
        }
        return BlogPostModel.query(on: req.db)
            .all()
            .mapEach(\.viewContext)
            .flatMap {
                req.view.render("Blog/Admin/Posts/List", Context(list: $0))
            }
    }
    
    func render(req: Request, form: BlogPostEditForm) -> EventLoopFuture<View> {
        struct Context<T: Encodable>: Encodable {
            let edit: T
        }
        return req.view.render("Blog/Admin/Posts/Edit", Context(edit: form))
    }
    
    func createView(req: Request) throws -> EventLoopFuture<View> {
        return self.render(req: req, form: .init())
    }
    
    func create(req: Request) throws -> EventLoopFuture<Response> {
        let form = try BlogPostEditForm(req: req)
        guard form.validate() else {
            return self.render(req: req, form: form).encodeResponse(for: req)
        }
        let model = BlogPostModel()
        model.image = "/images/posts/01.jpg"
        form.write(to: model)

        return BlogCategoryModel.query(on: req.db)
            .first()
            .unwrap(or: Abort(.notFound))
            .flatMap { category in
                model.$category.id = category.id!
                return model.create(on: req.db)
            }
            .map {
                req.redirect(to: model.id!.uuidString)
            }
    }

    func find(_ req: Request) throws -> EventLoopFuture<BlogPostModel> {
        guard
            let id = req.parameters.get("id"),
            let uuid = UUID(uuidString: id)
        else {
            throw Abort(.badRequest)
        }
        return BlogPostModel.find(uuid, on: req.db).unwrap(or: Abort(.notFound))
    }
    
    func updateView(req: Request) throws -> EventLoopFuture<View>  {
        try self.find(req).flatMap { model in
            let form = BlogPostEditForm()
            form.read(from: model)
            return self.render(req: req, form: form)
        }
    }

    func update(req: Request) throws -> EventLoopFuture<View> {
        let form = try BlogPostEditForm(req: req)
        guard form.validate() else {
            return self.render(req: req, form: form)
        }
        return try self.find(req)
        .flatMap { model in
            form.write(to: model)
            return model.update(on: req.db)
        }
        .flatMap {
            self.render(req: req, form: form)
        }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<String> {
        try self.find(req).flatMap { item in
            item.delete(on: req.db).map { item.id!.uuidString }
        }
    }
}
