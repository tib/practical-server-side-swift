import Foundation

public extension Blog.Category {
    
    struct List: Codable {
        public let id: UUID
        public let title: String
        
        public init(
            id: UUID,
            title: String
        ) {
            self.id = id
            self.title = title
        }
    }
    
    struct Detail: Codable {
        public let id: UUID
        public let title: String
        
        public init(
            id: UUID,
            title: String
        ) {
            self.id = id
            self.title = title
        }
    }

    struct Create: Codable {
        public let title: String
        
        public init(
            title: String
        ) {
            self.title = title
        }
    }
    
    struct Update: Codable {
        public let title: String
        
        public init(
            title: String
        ) {
            self.title = title
        }
    }
    
    struct Patch: Codable {
        public let title: String?
        
        public init(
            title: String?
        ) {
            self.title = title
        }
    }
}
