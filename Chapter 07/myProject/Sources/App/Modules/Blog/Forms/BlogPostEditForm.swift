import Foundation
import Vapor

final class BlogPostEditForm: Form {
    
    var model: BlogPostModel?
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    init() {
        super.init()
        
        action.multipart = true
        
        self.fields = [
            
            ImageField(key: "image", path: "blog/posts/")
                .read { [unowned self] in ($1 as! ImageField).imageKey = model?.image }
                .write { [unowned self] in model?.image = ($1 as! ImageField).imageKey ?? "" },
            
            TextField(key: "title")
                .config { $0.output.required = true }
                .validators { [
                    FormFieldValidator.required($1),
                ] }
                .read { [unowned self] in $1.output.value = model?.title }
                .write { [unowned self] in model?.title = $1.input },
            
            TextField(key: "slug")
                .config { $0.output.required = true }
                .validators { [
                    FormFieldValidator.required($1),
                ] }
                .read { [unowned self] in $1.output.value = model?.slug }
                .write { [unowned self] in model?.slug = $1.input }
            ,
            
            TextareaField(key: "excerpt")
                .config {
                    $0.output.required = true
                    $0.output.size = .s
                }
                .validators { [
                    FormFieldValidator.required($1),
                ] }
                .read { [unowned self] in $1.output.value = model?.excerpt }
                .write { [unowned self] in model?.excerpt = $1.input }
            ,
            TextField(key: "date")
                .config { [unowned self] in
                    $0.output.required = true
                    $0.output.value = formatter.string(from: Date())
                }
                .validators { [
                    FormFieldValidator.required($1),
                ] }
                .read { [unowned self] in $1.output.value = formatter.string(from: model?.date ?? Date()) }
                .write { [unowned self] in model?.date = formatter.date(from: $1.input) ?? Date() }
            ,
            
            SelectionField(key: "category", value: model?.$category.id.uuidString ?? "")
                .load { req, field in
                    BlogCategoryModel.query(on: req.db).all()
                        .mapEach { FormFieldOption(key: $0.id!.uuidString, label: $0.title) }
                        .map { field.output.options = $0 }
                }
                .read { [unowned self] req, field in field.output.value = model!.$category.id.uuidString }
                .write { [unowned self] req, field in model!.$category.id = UUID(uuidString: field.input)! },
            
            TextareaField(key: "content")
                .config {
                    $0.output.required = true
                    $0.output.size = .l
                }
                .read { [unowned self] in $1.output.value = model?.content }
                .write { [unowned self] in model?.content = $1.input }
            ,
        ]
    }
}
