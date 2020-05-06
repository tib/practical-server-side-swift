import Vapor
import Fluent
import Liquid

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

    func beforeRender(req: Request, form: BlogPostEditForm) -> EventLoopFuture<Void> {
        BlogCategoryModel.query(on: req.db).all()
        .mapEach(\.formFieldOption)
        .map { form.categoryId.options = $0 }
    }

    func render(req: Request, form: BlogPostEditForm) -> EventLoopFuture<View> {
        struct Context<T: Encodable>: Encodable {
            let edit: T
        }
        return self.beforeRender(req: req, form: form).flatMap {
            req.view.render("Blog/Admin/Posts/Edit", Context(edit: form))
        }
    }

    func createView(req: Request) throws -> EventLoopFuture<View> {
        return self.render(req: req, form: .init())
    }
    
    func beforeCreate(req: Request, model: BlogPostModel, form: BlogPostEditForm)
        -> EventLoopFuture<BlogPostModel>
    {
        var future: EventLoopFuture<BlogPostModel> = req.eventLoop.future(model)
        if let data = form.image.data {
            let key = "/blog/posts/" + UUID().uuidString + ".jpg"
            future = req.fs.upload(key: key, data: data).map { url in
                form.image.value = url
                model.imageKey = key
                model.image = url
                return model
            }
        }
        return future
    }

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let form = try BlogPostEditForm(req: req)
        return form.validate(req: req)
        .flatMap { isValid -> EventLoopFuture<Response> in
            guard isValid else {
                return self.render(req: req, form: form).encodeResponse(for: req)
            }
            let model = BlogPostModel()
            form.write(to: model)
            return self.beforeCreate(req: req, model: model, form: form)
            .flatMap { model in
                return model.create(on: req.db)
                    .map { req.redirect(to: model.id!.uuidString) }
            }
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

    func beforeUpdate(req: Request, model: BlogPostModel, form: BlogPostEditForm)
        -> EventLoopFuture<BlogPostModel>
    {
        var future: EventLoopFuture<BlogPostModel> = req.eventLoop.future(model)
        if
            (form.image.delete || form.image.data != nil),
            let imageKey = model.imageKey
        {
            future = req.fs.delete(key: imageKey).map {
                form.image.value = ""
                model.image = ""
                model.imageKey = nil
                return model
            }
        }
        if let data = form.image.data {
            return future.flatMap { model in
                let key = "/blog/posts/" + UUID().uuidString + ".jpg"
                return req.fs.upload(key: key, data: data).map { url in
                    form.image.value = url
                    model.imageKey = key
                    model.image = url
                    return model
                }
            }
        }
        return future
    }

    func update(req: Request) throws -> EventLoopFuture<View> {
        let form = try BlogPostEditForm(req: req)
        return form.validate(req: req).flatMap { isValid in
            guard isValid else {
                return self.render(req: req, form: form)
            }
            do {
                return try self.find(req)
                .flatMap { model in
                    self.beforeUpdate(req: req, model: model, form: form)
                }
                .flatMap { model in
                    form.write(to: model)
                    return model.update(on: req.db).map {
                        form.read(from: model)
                    }
                }
                .flatMap {
                    
                    self.render(req: req, form: form)
                }
            }
            catch {
                return req.eventLoop.future(error: error)
            }
        }
    }

    func beforeDelete(req: Request, model: BlogPostModel)
        -> EventLoopFuture<BlogPostModel>
    {
        if let key = model.imageKey {
            return req.fs.delete(key: key).map { model }
        }
        return req.eventLoop.future(model)
    }

    func delete(req: Request) throws -> EventLoopFuture<String> {
        try self.find(req)
        .flatMap { self.beforeDelete(req: req, model: $0) }
        .flatMap { model in
            model.delete(on: req.db).map { model.id!.uuidString }
        }
    }
}
