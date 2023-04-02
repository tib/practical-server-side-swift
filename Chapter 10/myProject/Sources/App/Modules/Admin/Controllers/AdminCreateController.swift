import Vapor

protocol AdminCreateController: ModelController {
    associatedtype CreateModelEditor: ModelEditorInterface
    
    func createTemplate(
        _ req: Request,
        _ editor: CreateModelEditor
    ) -> TemplateRepresentable
    
    func createView(
        _ req: Request
    ) async throws -> Response
    
    func createAction(
        _ req: Request
    ) async throws -> Response
    
    func createContext(
        _ req: Request,
        _ editor: CreateModelEditor
    ) -> AdminEditorPageContext
    
    func createBreadcrumbs(
        _ req: Request
    ) -> [LinkContext]
}

extension AdminCreateController {

    private func render(
        _ req: Request,
        editor: CreateModelEditor
    ) -> Response {
        req.templates.renderHtml(
            createTemplate(req, editor)
        )
    }

    func createView(
        _ req: Request
    ) async throws -> Response {
        let editor = CreateModelEditor(
            model: .init(),
            form: .init()
        )
        editor.form.fields = editor.formFields
        try await editor.load(req: req)
        return render(req, editor: editor)
    }
    
    func createAction(
        _ req: Request
    ) async throws -> Response {
        let model = DatabaseModel()
        let editor = CreateModelEditor(
            model: model as! CreateModelEditor.Model,
            form: .init()
        )
        editor.form.fields = editor.formFields
        try await editor.load(req: req)
        try await editor.process(req: req)
        let isValid = try await editor.validate(req: req)
        guard isValid else {
            return render(req, editor: editor)
        }
        try await editor.write(req: req)
        try await editor.model.create(on: req.db)
        try await editor.save(req: req)
        var components = req.url.path.pathComponents.dropLast()
        components += editor.model.id!.uuidString.pathComponents
        return req.redirect(to: "/" + components.string + "/update/")
    }
    
    func createTemplate(
        _ req: Request,
        _ editor: CreateModelEditor
    ) -> TemplateRepresentable {
        AdminEditorPageTemplate(
            createContext(req, editor)
        )
    }

    func createContext(
        _ req: Request,
        _ editor: CreateModelEditor
    ) -> AdminEditorPageContext {
        let context = FormContext(
            action: editor.form.action,
            fields: editor.form.fields.map { $0.render(req: req) },
            error: editor.form.error,
            submit: editor.form.submit
        )
        return .init(
            title: "Create",
            form: context,
            breadcrumbs: createBreadcrumbs(req)
        )
    }
    
    func createBreadcrumbs(
        _ req: Request
    ) -> [LinkContext] {
        [
            LinkContext(
                label: DatabaseModel.Module.identifier.capitalized,
                dropLast: 2
            ),
            LinkContext(
                label: modelName.plural.capitalized,
                dropLast: 1
            ),
        ]
    }
}
