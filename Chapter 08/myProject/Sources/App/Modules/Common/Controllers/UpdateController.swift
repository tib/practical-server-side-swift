import Vapor
import Fluent

protocol UpdateController: GetController {
    associatedtype UpdateForm: EditForm
}

extension UpdateController {

    func renderUpdateView(_ req: Request, _ form: UpdateForm) -> EventLoopFuture<View> {
        req.view.render("Common/Edit", form)
    }
    
    func updateView(req: Request) throws -> EventLoopFuture<View>  {
        let form = UpdateForm()
        return try find(req).flatMap { model in
            form.context.model = model as? UpdateForm.Model
            return form.load(req: req)
                .flatMap { form.read(req: req) }
        }
        .flatMap { renderUpdateView(req, form) }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let form = UpdateForm()
        return form.load(req: req)
            .flatMap { form.process(req: req) }
            .flatMap { form.validate(req: req) }
            .flatMap { isValid in
                guard isValid else {
                    return renderUpdateView(req, form)
                        .encodeResponse(for: req)
                }
                do {
                    return try find(req)
                        .map { model in
                            form.context.model = model as? UpdateForm.Model
                        }
                        .flatMap { form.write(req: req) }
                        .flatMap { form.context.model!.update(on: req.db) }
                        .flatMap { form.save(req: req) }
                        .flatMap { form.read(req: req) }
                        .flatMap { renderUpdateView(req, form) }
                        .encodeResponse(for: req)
                }
                catch {
                    return req.eventLoop.future(error: error)
                }
            }
    }
}
