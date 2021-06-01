import Vapor
import Fluent
import Tau

struct BlogPostAdminController {
    
    func createView(req: Request) throws -> EventLoopFuture<View> {
        req.tau.render(template: "Blog/Admin/Posts/Edit", context: [
            "form": BlogPostEditForm().encodeToTemplateData(),
        ])
    }
    
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
}
