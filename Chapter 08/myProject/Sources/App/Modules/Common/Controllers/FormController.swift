import Vapor
import Fluent

protocol EditFormController: ModelController {
}

extension EditFormController {

    func render(_ req: Request, _ form: BlogPostEditForm) -> EventLoopFuture<View> {
        req.view.render("Common/Edit", form)
    }

}
