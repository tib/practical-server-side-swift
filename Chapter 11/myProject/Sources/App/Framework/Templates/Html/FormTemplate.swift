import Vapor
import SwiftHtml

public struct FormTemplate: TemplateRepresentable {
    
    var context: FormContext
    
    public init(
        _ context: FormContext
    ) {
        self.context = context
    }

    @TagBuilder
    public func render(
        _ req: Request
    ) -> Tag {
        Form {
            if let error = context.error {
                Section {
                    P(error)
                        .class("error")
                }
            }
            for field in context.fields {
                Section {
                    field.render(req)
                }
            }
            
            Section {
                Input()
                    .type(.submit)
                    .value(context.submit ?? "Save")
            }
        }
        .method(context.action.method)
        .action(context.action.url)
        .enctype(context.action.enctype)
    }
}
