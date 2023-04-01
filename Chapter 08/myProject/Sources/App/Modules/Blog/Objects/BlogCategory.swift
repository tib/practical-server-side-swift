import Foundation

extension Blog {

    enum Category {
        
    }
}

extension Blog.Category {
    
    struct List: Codable {
        let id: UUID
        let title: String
    }
}
