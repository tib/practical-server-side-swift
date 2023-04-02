import Foundation

extension User.Account {
    
    struct List: Codable {
        let id: UUID
        let email: String
    }
    
    struct Detail: Codable {
        let id: UUID
        let email: String
    }
    
    struct Create: Codable {
        let email: String
        let password: String
    }
    
    struct Update: Codable {
        let email: String
        let password: String?
    }
    
    struct Patch: Codable {
        let email: String?
        let password: String?
    }
}
