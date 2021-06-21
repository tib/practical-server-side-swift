import Vapor
import Fluent

protocol UpdateController: EditFormController, GetController {
    
}

extension UpdateController {
    
    func updateView(req: Request) throws -> EventLoopFuture<View>  {
        let form = BlogPostEditForm()
        return try find(req).flatMap { model in
            form.context.model = model
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
                        .map { model in form.context.model = model }
                        .flatMap { form.write(req: req) }
                        .flatMap { form.context.model!.update(on: req.db) }
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
}
