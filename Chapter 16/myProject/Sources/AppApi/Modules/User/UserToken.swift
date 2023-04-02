import Foundation

public extension User.Token {
    
    struct Detail: Codable {
        public let id: UUID
        public let value: String
        public let user: User.Account.Detail
        
        public init(
            id: UUID,
            value: String,
            user: User.Account.Detail
        ) {
            self.id = id
            self.value = value
            self.user = user
        }
    }
}
