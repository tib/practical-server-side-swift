import Vapor
import Fluent

final class UserTokenModel: Model {
    static let schema = "user_tokens"
    
    struct FieldKeys {
        static var value: FieldKey { "value" }
        static var userId: FieldKey { "user_id" }
    }
    
    // MARK: - fields
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.value) var value: String
    @Parent(key: FieldKeys.userId) var user: UserModel

    init() { }
    
    init(id: UserTokenModel.IDValue? = nil,
         value: String,
         userId: UserModel.IDValue)
    {
        self.id = id
        self.value = value
        $user.id = userId
    }
}

extension UserTokenModel: ModelTokenAuthenticatable {
    static let valueKey = \UserTokenModel.$value
    static let userKey = \UserTokenModel.$user
    
    var isValid: Bool {
        true
    }
}
