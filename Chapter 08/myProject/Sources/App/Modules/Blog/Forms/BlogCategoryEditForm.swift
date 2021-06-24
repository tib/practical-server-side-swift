import Foundation
import Vapor

struct BlogCategoryEditForm: EditForm {
    
    var context: FormContext<BlogCategoryModel>

    init() {
        context = .init()
        context.form.fields = createFormFields()
    }

    private func createFormFields() -> [FormComponent] {
        [

            TextField(key: "title")
                .config { $0.output.required = true }
                .validators { [
                    FormFieldValidator.required($1),
                ] }
                .read { $1.output.value = context.model?.title }
                .write { context.model?.title = $1.input },
        ]
    }
}
