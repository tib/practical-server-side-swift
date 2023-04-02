import Vapor

public struct AuthenticatedUser {

    public let id: UUID
    public let email: String
    
    public init(
        id: UUID,
        email: String
    ) {
        self.id = id
        self.email = email
    }
}

extension AuthenticatedUser: SessionAuthenticatable {
    public var sessionID: UUID { id }
}
