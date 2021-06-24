import Vapor
import Fluent

protocol CreateController: ModelController {
    associatedtype CreateForm: EditForm
}

extension CreateController {
    
    func renderCreateView(_ req: Request, _ form: CreateForm) -> EventLoopFuture<View> {
        req.view.render("Common/Edit", form)
    }
    
    func createView(req: Request) throws -> EventLoopFuture<View> {
        let form = CreateForm()
        return form.load(req: req)
            .flatMap { renderCreateView(req, form) }
    }
    
    func create(req: Request) throws -> EventLoopFuture<Response> {
        let form = CreateForm()
                
        return form.load(req: req)
            .flatMap { form.process(req: req) }
            .flatMap { form.validate(req: req) }
            .flatMap { isValid in
                guard isValid else {
                    return renderCreateView(req, form)
                        .encodeResponse(for: req)
                }
                let model = Model()
                form.context.model = model as? CreateForm.Model
                return form.write(req: req)
                    .flatMap { form.context.model!.create(on: req.db) }
                    .flatMap { form.load(req: req) }
                    .flatMap { form.read(req: req) }
                    .flatMap { renderCreateView(req, form) }
                    .encodeResponse(for: req)
            }
    }

}


