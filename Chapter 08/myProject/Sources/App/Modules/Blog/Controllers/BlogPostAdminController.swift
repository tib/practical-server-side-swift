import Vapor
import Fluent
import Tau

struct BlogPostAdminController: ListController {
    typealias Model = BlogPostModel
    
    
    func listTable(_ models: [Model]) -> Table {
        Table(columns: ["title"], rows: models.map { model in
            TableRow(id: model.id!.uuidString, cells: [TableCell(model.title)])
        })
    }
    
    // ...


    private func render(_ req: Request, _ form: BlogPostEditForm) -> EventLoopFuture<View> {
        req.tau.render(template: "Blog/Admin/Posts/Edit", context: [
            "form": form.encodeToTemplateData(),
        ])
    }
    
    func createView(req: Request) throws -> EventLoopFuture<View> {
        let form = BlogPostEditForm()
        return form.load(req: req).flatMap { render(req, form) }
    }
    
    func create(req: Request) throws -> EventLoopFuture<Response> {
        let form = BlogPostEditForm()
                
        return form.load(req: req)
            .flatMap { form.process(req: req) }
            .flatMap { form.validate(req: req) }
            .flatMap { isValid in
                guard isValid else {
                    return render(req, form).encodeResponse(for: req)
                }
                let model = BlogPostModel()
                form.model = model
                return form.write(req: req)
                    .flatMap { form.model!.create(on: req.db) }
                    .flatMap { form.load(req: req) }
                    .flatMap { form.read(req: req) }
                    .flatMap { render(req, form) }
                    .encodeResponse(for: req)
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
        return form.load(req: req)
            .flatMap { form.process(req: req) }
            .flatMap { form.validate(req: req) }
            .flatMap { isValid in
                guard isValid else {
                    return render(req, form)
                        .encodeResponse(for: req)
                }
                do {
                    return try find(req)
                        .map { model in form.model = model }
                        .flatMap { form.write(req: req) }
                        .flatMap { form.model!.update(on: req.db) }
                        .flatMap { form.save(req: req) }
                        .flatMap { form.read(req: req) }
                        .flatMap { render(req, form) }
                        .encodeResponse(for: req)
                }
                catch {
                    return req.eventLoop.future(error: error)
                }
            }
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
