import Foundation

public struct UserTokenGetObject: Codable {

    public let id: UUID
    public let value: String
    
    public init(id: UUID, value: String) {
        self.id = id
        self.value = value
    }
}
