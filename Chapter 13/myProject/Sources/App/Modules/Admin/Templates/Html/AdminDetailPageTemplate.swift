import Vapor
import SwiftHtml

struct AdminDetailPageTemplate: TemplateRepresentable {
    
    var context: AdminDetailPageContext
    
    init(
        _ context: AdminDetailPageContext
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
                
                Dl {
                    for item in context.fields {
                        DetailTemplate(item).render(req)
                    }
                }
                
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
