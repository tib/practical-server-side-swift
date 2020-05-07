import Vapor
import Fluent
import ViperKit

final class UserModel: ViperModel {
    typealias Module = UserModule
        
    static let name = "users"

    struct FieldKeys {
        static var email: FieldKey { "email" }
        static var password: FieldKey { "password" }
    }
    
    // MARK: - fields
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.email) var email: String
    @Field(key: FieldKeys.password) var password: String
    
    init() { }
    
    init(id: UserModel.IDValue? = nil,
         email: String,
         password: String)
    {
        self.id = id
        self.email = email
        self.password = password
    }
}

extension UserModel: SessionAuthenticatable {
    typealias SessionID = UUID

    var sessionID: SessionID { self.id! }
}


