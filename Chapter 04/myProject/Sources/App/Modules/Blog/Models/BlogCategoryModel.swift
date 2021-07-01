import Vapor
import Fluent

final class BlogCategoryModel: ModelInterface {
    typealias Module = BlogModule

    static let key: String = "categories"
    static let name: Noun = .init(singular: "category", plural: "categories")
    
    struct FieldKeys {
        static var title: FieldKey { "title" }
    }
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.title) var title: String
    @Children(for: \.$category) var posts: [BlogPostModel]
    
    init() { }
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
