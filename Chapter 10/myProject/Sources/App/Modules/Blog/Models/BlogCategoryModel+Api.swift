import Vapor

extension BlogCategoryModel: ListContentRepresentable {

    struct ListItem: Content {
        var id: String
        var title: String

        init(model: BlogCategoryModel) {
            id = model.id!.uuidString
            title = model.title
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
            id = model.id!.uuidString
            title = model.title
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
        title = content.title
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
        title = content.title
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
        title = content.title
    }
}

extension BlogCategoryModel: DeleteContentRepresentable {}
