import Vapor
import Fluent

protocol CreateController: EditFormController {
    associatedtype CreateForm: EditForm
}

extension CreateController {
    
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
                form.context.model = model
                return form.write(req: req)
                    .flatMap { form.context.model!.create(on: req.db) }
                    .flatMap { form.load(req: req) }
                    .flatMap { form.read(req: req) }
                    .flatMap { render(req, form) }
                    .encodeResponse(for: req)
            }
    }

}


