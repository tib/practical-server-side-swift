import Vapor
import Fluent

final class BlogCategoryModel: Model {

    static let schema = "blog_categories"
    
    struct FieldKeys {
        static var title: FieldKey { "title" }
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.title) var title: String
    @Children(for: \.$category) var posts: [BlogPostModel]
    
    init() { }
    
    init(id: UUID? = nil,
         title: String)
    {
        self.id = id
        self.title = title
    }
}

extension BlogCategoryModel: ViewContextRepresentable {

    struct ViewContext: Encodable {
        var id: String
        var title: String

        init(model: BlogCategoryModel) {
            self.id = model.id!.uuidString
            self.title = model.title
        }
    }

    var viewContext: ViewContext { .init(model: self) }
    var viewIdentifier: String { self.id!.uuidString }
}

extension BlogCategoryModel: FormFieldOptionRepresentable {
    var formFieldOption: FormFieldOption {
        .init(key: self.id!.uuidString, label: self.title)
    }
}

