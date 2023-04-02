import Vapor

final class BlogPostEditForm: AbstractForm {
    
    unowned var model: BlogPostModel
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    public init(_ model: BlogPostModel) {
        var url = "/admin/blog/posts/"
        if let id = model.$id.value {
            url = url + id.uuidString + "/update/"
        }
        else {
            url = url + "create/"
        }
        self.model = model
        super.init(
            action: .init(
                method: .post,
                url: url,
                enctype: .multipart
            )
        )
        self.fields = createFields()
    }
    
    @FormComponentBuilder
    func createFields() -> [FormComponent] {
        ImageField("image", path: "blog/post")
            .read { [unowned self] in
                $1.output.context.previewUrl = model.imageKey
                ($1 as! ImageField).imageKey = model.imageKey
            }
            .write { [unowned self] in
                model.imageKey = ($1 as! ImageField).imageKey ?? ""
            }
        
        InputField("slug")
            .config {
                $0.output.context.label.required = true
            }
            .validators {
                FormFieldValidator.required($1)
            }
            .read { [unowned self] in
                $1.output.context.value = model.slug
            }
            .write { [unowned self] in
                model.slug = $1.input
            }
        
        InputField("title")
            .config {
                $0.output.context.label.required = true
            }
            .validators {
                FormFieldValidator.required($1)
            }
            .read { [unowned self] in
                $1.output.context.value = model.title
            }
            .write { [unowned self] in
                model.title = $1.input
            }
        
        InputField("date")
            .config {
                $0.output.context.label.required = true
                $0.output.context.value = dateFormatter.string(from: Date())
            }
            .validators {
                FormFieldValidator.required($1)
            }
            .read { [unowned self] in
                $1.output.context.value = dateFormatter.string(from: model.date)
            }
            .write { [unowned self] in
                model.date = dateFormatter.date(from: $1.input) ?? Date()
            }
        
        TextareaField("excerpt")
            .read { [unowned self] in
                $1.output.context.value = model.excerpt
            }
            .write { [unowned self] in
                model.excerpt = $1.input
            }
        
        TextareaField("content")
            .read { [unowned self] in
                $1.output.context.value = model.content
            }
            .write { [unowned self] in
                model.content = $1.input
            }
        
        SelectField("category")
            .load { req, field in
                let categories = try await BlogCategoryModel
                    .query(on: req.db)
                    .all()
                field.output.context.options = categories.map {
                    OptionContext(key: $0.id!.uuidString, label: $0.title)
                }
            }
            .read { [unowned self] req, field in
                field.output.context.value = model.$category.id.uuidString
            }
            .write { [unowned self] req, field in
                if
                    let uuid = UUID(uuidString: field.input),
                    let category = try await BlogCategoryModel
                        .find(uuid, on: req.db)
                {
                    model.$category.id = category.id!
                }
            }
    }
}
