import Foundation

public struct BlogCategoryListObject: Codable {
    public let id: UUID
    public let title: String
    
    public init(id: UUID, title: String) {
        self.id = id
        self.title = title
    }
}

public struct BlogCategoryGetObject: Codable {
    public let id: UUID
    public let title: String
    public var posts: [BlogPostListObject]?
    
    public init(id: UUID, title: String, posts: [BlogPostListObject]? = nil) {
        self.id = id
        self.title = title
        self.posts = posts
    }
}

public struct BlogCategoryCreateObject: Codable {
    public var title: String
    
    public init(title: String) {
        self.title = title
    }
}

public struct BlogCategoryUpdateObject: Codable {
    public var title: String
    
    public init(title: String) {
        self.title = title
    }
}

public struct BlogCategoryPatchObject: Codable {
    public var title: String
    
    public init(title: String) {
        self.title = title
    }
}
