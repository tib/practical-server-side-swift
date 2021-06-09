import Vapor
import Fluent
import Tau

struct BlogPostAdminController {
    
    private func render(_ req: Request, _ form: BlogPostEditForm) -> EventLoopFuture<View> {
        req.tau.render(template: "Blog/Admin/Posts/Edit", context: [
            "form": form.encodeToTemplateData(),
        ])
    }
    
    func createView(req: Request) throws -> EventLoopFuture<View> {
        let form = BlogPostEditForm()
        return form.load(req: req)
            .flatMap { form.read(req: req) }
            .flatMap { render(req, form) }
    }
    
    func create(req: Request) throws -> EventLoopFuture<Response> {
        let form = BlogPostEditForm()
        form.model = BlogPostModel()
        
        return form.load(req: req)
            .flatMap { form.read(req: req) }
            .flatMap { form.process(req: req) }
            .flatMap { form.validate(req: req) }
            .flatMap { isValid in
                guard isValid else {
                    return render(req, form).encodeResponse(for: req)
                }
                return form.save(req: req)
                    .flatMap { form.model!.save(on: req.db) }
                    .flatMap { form.load(req: req) }
                    .flatMap { render(req, form) }
                    .encodeResponse(for: req)
            }
    }
    //...
    
    
    func listView(req: Request) throws -> EventLoopFuture<View> {
        BlogPostModel.query(on: req.db)
            .all()
            .mapEach { $0.encodeToTemplateData() }
            .flatMap {
                req.tau.render(template: "Blog/Admin/Posts/List", context: [
                    "list": .array($0)
                ])
            }
    }
    
    func find(_ req: Request) throws -> EventLoopFuture<BlogPostModel> {
        guard
            let id = req.parameters.get("id"),
            let uuid = UUID(uuidString: id)
        else {
            throw Abort(.notFound)
        }
        return BlogPostModel.find(uuid, on: req.db).unwrap(or: Abort(.notFound))
    }

    func updateView(req: Request) throws -> EventLoopFuture<View>  {
        let form = BlogPostEditForm()
        return try find(req).flatMap { model in
            form.model = model
            return form.load(req: req)
                .flatMap { form.read(req: req) }
        }
        .flatMap { render(req, form) }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let form = BlogPostEditForm()
        return form.process(req: req)
            .flatMap {
                do {
                    return try find(req).map { model in form.model = model }
                }
                catch {
                    return req.eventLoop.future(error: error)
                }
            }
            .flatMap { form.save(req: req) }
            .flatMap { form.model!.save(on: req.db) }
            .flatMap { form.load(req: req) }
            .flatMap { form.read(req: req) }
            .flatMap { render(req, form) }
            .encodeResponse(for: req)
    }
    
    // ...
    func deleteView(req: Request) throws -> EventLoopFuture<View> {
        try find(req).flatMap { model in
            req.tau.render(template: "Blog/Admin/Posts/Delete", context: [
                "post": model.encodeToTemplateData()
            ])
        }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        try self.find(req)
            .flatMap { $0.delete(on: req.db) }
            .map { req.redirect(to: "/admin/blog/posts/") }
    }
}
