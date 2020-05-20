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

extension BlogCategoryModel: ListContentRepresentable {

    struct ListItem: Content {
        var id: String
        var title: String

        init(model: BlogCategoryModel) {
            self.id = model.id!.uuidString
            self.title = model.title
        }
    }

    var listContent: ListItem { .init(model: self) }
}

extension BlogCategoryModel: GetContentRepresentable {

    struct GetContent: Content {
        var id: String
        var title: String
        var posts: [BlogPostModel.ListItem]?

        init(model: BlogCategoryModel) {
            self.id = model.id!.uuidString
            self.title = model.title
        }
    }

    var getContent: GetContent { .init(model: self) }
}

extension BlogCategoryModel: CreateContentRepresentable {

    struct CreateContent: ValidatableContent {
        var title: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("title", as: String.self, is: !.empty)
        }
    }

    func create(_ content: CreateContent) throws {
        self.title = content.title
    }
}

extension BlogCategoryModel: UpdateContentRepresentable {

    struct UpdateContent: ValidatableContent {
        var title: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("title", as: String.self, is: !.empty)
        }
    }
    
    func update(_ content: UpdateContent) throws {
        self.title = content.title
    }
}

extension BlogCategoryModel: PatchContentRepresentable {

    struct PatchContent: ValidatableContent {
        var title: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("title", as: String.self, is: !.empty)
        }
    }
    
    func patch(_ content: PatchContent) throws {
        self.title = content.title
    }
}

extension BlogCategoryModel: DeleteContentRepresentable {}
