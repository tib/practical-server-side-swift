import Foundation

extension Blog.Category {
    
    struct List: Codable {
        let id: UUID
        let title: String
    }
    
    struct Detail: Codable {
        let id: UUID
        let title: String
    }

    struct Create: Codable {
        let title: String
    }
    
    struct Update: Codable {
        let title: String
    }
    
    struct Patch: Codable {
        let title: String?
    }
}
