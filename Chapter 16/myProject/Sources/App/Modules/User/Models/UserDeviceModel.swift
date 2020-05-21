import Vapor
import Fluent
import ViperKit

final class UserDeviceModel: ViperModel {
    typealias Module = UserModule

    static let name = "devices"

    struct FieldKeys {
        static var token: FieldKey { "token" }
        static var userId: FieldKey { "user_id" }
    }

    // MARK: - fields

    @ID() var id: UUID?
    @Field(key: FieldKeys.token) var token: String
    @Parent(key: FieldKeys.userId) var user: UserModel

    init() { }

    init(id: UserDeviceModel.IDValue? = nil,
         token: String,
         userId: UUID)
    {
        self.id = id
        self.token = token
        self.$user.id = userId
    }
}
