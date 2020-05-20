import Vapor
import Fluent
import ContentApi
import ViperKit

final class UserTokenModel: ViperModel {
    typealias Module = UserModule
    
    static let name = "tokens"
    
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
        self.$user.id = userId
    }
}

extension UserTokenModel {

    static func create(on db: Database, for userId: UUID) -> EventLoopFuture<UserTokenModel> {
        let tokenValue = [UInt8].random(count: 16).base64
        let token = UserTokenModel(value: tokenValue, userId: userId)
        return token.create(on: db).map { token }
    }
}

extension UserTokenModel: ModelTokenAuthenticatable {
    static let valueKey = \UserTokenModel.$value
    static let userKey = \UserTokenModel.$user
    
    var isValid: Bool {
        true
    }
}

extension UserTokenModel: GetContentRepresentable {

    struct GetContent: Content {
        var id: String
        var value: String

        init(model: UserTokenModel) {
            self.id = model.id!.uuidString
            self.value = model.value
        }
    }

    var getContent: GetContent { .init(model: self) }
}
