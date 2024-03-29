import Vapor

final class DeleteForm: AbstractForm {
    
    init() {
        super.init()
        
        self.action.method = .post
        self.submit = "Delete"
    }
}

protocol AdminDeleteController: ModelController {
    
    func deleteView(
        _ req: Request
    ) async throws -> Response
    
    func deleteAction(
        _ req: Request
    ) async throws -> Response
    
    func deleteTemplate(
        _ req: Request,
        _ model: DatabaseModel,
        _ form: DeleteForm
    ) -> TemplateRepresentable
    
    func deleteInfo(
        _ model: DatabaseModel
    ) -> String
    
    func deleteContext(
        _ req: Request,
        _ model: DatabaseModel,
        _ form: DeleteForm
    ) -> AdminDeletePageContext
}

extension AdminDeleteController {
    
    func deleteView(
        _ req: Request
    ) async throws -> Response {
        let model = try await findBy(identifier(req), on: req.db)
        let form = DeleteForm()
        return req.templates.renderHtml(
            deleteTemplate(req, model, form)
        )
    }
    
    func deleteAction(
        _ req: Request
    ) async throws -> Response {
        let model = try await findBy(identifier(req), on: req.db)
        try await model.delete(on: req.db)
        
        var url = req.url.path
        if let redirect = try? req.query.get(String.self, at: "redirect") {
            url = redirect
        }
        return req.redirect(to: url)
    }
    
    func deleteTemplate(
        _ req: Request,
        _ model: DatabaseModel,
        _ form: DeleteForm
    ) -> TemplateRepresentable {
        AdminDeletePageTemplate(
            deleteContext(req, model, form)
        )
    }
    
    func deleteContext(
        _ req: Request,
        _ model: DatabaseModel,
        _ form: DeleteForm
    ) -> AdminDeletePageContext {
        .init(
            title: "Delete",
            name: deleteInfo(model),
            type: "model",
            form: form.getContext(req)
        )
    }
}
