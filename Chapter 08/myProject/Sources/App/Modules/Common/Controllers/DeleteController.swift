import Vapor
import Fluent

protocol DeleteController: GetController {
    
}

extension DeleteController {

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
