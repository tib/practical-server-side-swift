import Vapor

extension UserTokenModel: GetContentRepresentable {

    struct GetContent: Content {
        var id: String
        var value: String

        init(model: UserTokenModel) {
            id = model.id!.uuidString
            value = model.value
        }
    }

    var getContent: GetContent { .init(model: self) }
}
