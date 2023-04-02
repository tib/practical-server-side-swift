import Foundation

extension User.Token {
    
    struct Detail: Codable {
        let id: UUID
        let value: String
        let user: User.Account.Detail
    }
}
