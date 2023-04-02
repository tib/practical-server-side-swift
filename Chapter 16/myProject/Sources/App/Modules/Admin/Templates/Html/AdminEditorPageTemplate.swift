import Vapor
import SwiftHtml

struct AdminEditorPageTemplate: TemplateRepresentable {

    var context: AdminEditorPageContext

    init(
        _ context: AdminEditorPageContext
    ) {
        self.context = context
    }

    @TagBuilder
    func render(
        _ req: Request
    ) -> Tag {
        AdminIndexTemplate(
            .init(
                title: context.title,
                breadcrumbs: context.breadcrumbs
            )
        ) {
            Div {
                Div {
                    H1(context.title)
                    for item in context.navigation {
                        LinkTemplate(item).render(req)
                    }
                }
                .class("lead")
               
                FormTemplate(context.form).render(req)

                Section {
                    for item in context.actions {
                        LinkTemplate(item).render(req)
                    }
                }
            }
            .class("container")
        }
        .render(req)
    }
}
