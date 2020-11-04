import Vapor
import Fluent

final class UserModel: ViperModel {
    
    typealias Module = UserModule

    static var name: String = "users"

    struct FieldKeys {
        static var email: FieldKey { "email" }
        static var password: FieldKey { "password" }
        static var appleId: FieldKey { "appleId" }
    }
    
    // MARK: - fields
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.email) var email: String
    @Field(key: FieldKeys.password) var password: String
    @Field(key: FieldKeys.appleId) var appleId: String?
    
    init() { }
    
    init(id: UserModel.IDValue? = nil,
         email: String,
         password: String,
         appleId: String? = nil)
    {
        self.id = id
        self.email = email
        self.password = password
        self.appleId = appleId
    }
}

extension UserModel: SessionAuthenticatable {
    typealias SessionID = UUID

    var sessionID: SessionID { id! }
}

extension UserModel: Authenticatable {
    
}
