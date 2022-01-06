//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

import Vapor

protocol AdminUpdateController: ModelController {
    associatedtype UpdateModelEditor: ModelEditorInterface
        
    func updateView(_ req: Request) async throws -> Response
    func updateAction(_ req: Request) async throws -> Response
    
    func updateTemplate(_ req: Request, _ editor: UpdateModelEditor) async -> TemplateRepresentable
    func updateContext(_ req: Request, _ editor: UpdateModelEditor) async -> AdminEditorPageContext
    func updateBreadcrumbs(_ req: Request, _ model: DatabaseModel) -> [LinkContext]
    func updateNavigation(_ req: Request, _ model: DatabaseModel) -> [LinkContext]
}

extension AdminUpdateController {
        
    private func render(_ req: Request, editor: UpdateModelEditor) async -> Response {
        return req.templates.renderHtml(await updateTemplate(req, editor))
    }

    func updateView(_ req: Request) async throws -> Response {
        let model = try await findBy(identifier(req), on: req.db)
        let editor = UpdateModelEditor(model: model as! UpdateModelEditor.Model, form: .init())
        editor.form.fields = editor.formFields
        try await editor.load(req: req)
        try await editor.read(req: req)
        return await render(req, editor: editor)
    }

    func updateAction(_ req: Request) async throws -> Response {
        let model = try await findBy(identifier(req), on: req.db)
        let editor = UpdateModelEditor(model: model as! UpdateModelEditor.Model, form: .init())
        editor.form.fields = editor.formFields
        try await editor.load(req: req)
        try await editor.process(req: req)
        let isValid = try await editor.validate(req: req)
        guard isValid else {
            return await render(req, editor: editor)
        }
        try await editor.write(req: req)
        try await editor.model.update(on: req.db)
        try await editor.save(req: req)
        return req.redirect(to: req.url.path)
    }
    
    func updateTemplate(_ req: Request, _ editor: UpdateModelEditor) async -> TemplateRepresentable {
        await AdminEditorPageTemplate(updateContext(req, editor))
    }
    
    func updateContext(_ req: Request, _ editor: UpdateModelEditor) async -> AdminEditorPageContext {
       .init(title: "Update",
             form: editor.form.getContext(req),
             navigation: updateNavigation(req, editor.model as! DatabaseModel),
             breadcrumbs: updateBreadcrumbs(req, editor.model as! DatabaseModel),
             actions: [
                LinkContext(label: "Delete",
                            path: "delete/?redirect=" + req.url.path.pathComponents.dropLast(2).string + "&cancel=" + req.url.path,
                            dropLast: 1),
             ])
    }
    
    func updateBreadcrumbs(_ req: Request, _ model: DatabaseModel) -> [LinkContext] {
        [
            LinkContext(label: DatabaseModel.Module.identifier.capitalized, dropLast: 3),
            LinkContext(label: modelName.plural.capitalized, dropLast: 2),
        ]
    }
    
    func updateNavigation(_ req: Request, _ model: DatabaseModel) -> [LinkContext] {
        [
            LinkContext(label: "Details", dropLast: 1),
        ]
    }
}
