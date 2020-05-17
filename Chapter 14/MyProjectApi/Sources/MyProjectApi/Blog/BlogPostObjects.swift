import Foundation

public struct BlogPostListObject: Codable {
    public let id: UUID
    public let title: String
    public let slug: String
    public let image: String
    public let excerpt: String
    public let date: Date
    
    public init(id: UUID, title: String, slug: String, image: String, excerpt: String, date: Date) {
        self.id = id
        self.title = title
        self.slug = slug
        self.image = image
        self.excerpt = excerpt
        self.date = date
    }
}

public struct BlogPostGetObject: Codable {
    public var id: UUID
    public var title: String
    public var slug: String
    public var image: String
    public var excerpt: String
    public var date: Date
    public var content: String
    
    public init(id: UUID, title: String, slug: String, image: String, excerpt: String, date: Date, content: String) {
        self.id = id
        self.title = title
        self.slug = slug
        self.image = image
        self.excerpt = excerpt
        self.date = date
        self.content = content
    }
}

public struct BlogPostUpsertObject: Codable {
    public var title: String
    public var slug: String
    public var image: String
    public var excerpt: String
    public var date: Date
    public var content: String
    public var categoryId: String
    
    public init(title: String, slug: String, image: String, excerpt: String, date: Date, content: String, categoryId: String) {
        self.title = title
        self.slug = slug
        self.image = image
        self.excerpt = excerpt
        self.date = date
        self.content = content
        self.categoryId = categoryId
    }
}

public struct BlogPostPatchObject: Codable {
    public var title: String?
    public var slug: String?
    public var image: String?
    public var excerpt: String?
    public var date: Date?
    public var content: String?
    public var categoryId: String?
    
    public init(title: String? = nil, slug: String? = nil, image: String? = nil, excerpt: String? = nil, date: Date? = nil, content: String? = nil, categoryId: String? = nil) {
        self.title = title
        self.slug = slug
        self.image = image
        self.excerpt = excerpt
        self.date = date
        self.content = content
        self.categoryId = categoryId
    }
}

