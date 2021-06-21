import Foundation
import Vapor

struct BlogPostEditForm: EditForm {
    
    var context: FormContext<BlogPostModel>
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    init() {
        context = .init()
        context.form.action.multipart = true
        
        context.form.fields = createFormFields()
    }

    private func createFormFields() -> [FormComponent] {
        [
            ImageField(key: "image", path: "blog/posts/")
                .read { ($1 as! ImageField).imageKey = context.model?.image }
                .write { context.model?.image = ($1 as! ImageField).imageKey ?? "" },
            
            TextField(key: "title")
                .config { $0.output.required = true }
                .validators { [
                    FormFieldValidator.required($1),
                ] }
                .read { $1.output.value = context.model?.title }
                .write { context.model?.title = $1.input },
            
            TextField(key: "slug")
                .config { $0.output.required = true }
                .validators { [
                    FormFieldValidator.required($1),
                ] }
                .read { $1.output.value = context.model?.slug }
                .write { context.model?.slug = $1.input }
            ,
            
            TextareaField(key: "excerpt")
                .config {
                    $0.output.required = true
                    $0.output.size = .s
                }
                .validators { [
                    FormFieldValidator.required($1),
                ] }
                .read { $1.output.value = context.model?.excerpt }
                .write { context.model?.excerpt = $1.input }
            ,
            TextField(key: "date")
                .config {
                    $0.output.required = true
                    $0.output.value = formatter.string(from: Date())
                }
                .validators { [
                    FormFieldValidator.required($1),
                ] }
                .read { $1.output.value = formatter.string(from: context.model?.date ?? Date()) }
                .write { context.model?.date = formatter.date(from: $1.input) ?? Date() }
            ,
            
            SelectionField(key: "category", value: context.model?.$category.id.uuidString ?? "")
                .load { req, field in
                    BlogCategoryModel.query(on: req.db).all()
                        .mapEach { FormFieldOption(key: $0.id!.uuidString, label: $0.title) }
                        .map { field.output.options = $0 }
                }
                .read { req, field in field.output.value = context.model!.$category.id.uuidString }
                .write { req, field in context.model!.$category.id = UUID(uuidString: field.input)! },
            
            TextareaField(key: "content")
                .config {
                    $0.output.required = true
                    $0.output.size = .l
                }
                .read { $1.output.value = context.model?.content }
                .write { context.model?.content = $1.input }
            ,
        ]
    }
}
