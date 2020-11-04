import Vapor
import MyProjectApi

extension UserTokenGetObject: Content {}
extension UserTokenModel: GetContentRepresentable {
    var getContent: UserTokenGetObject { .init(id: id!, value: value) }
}
