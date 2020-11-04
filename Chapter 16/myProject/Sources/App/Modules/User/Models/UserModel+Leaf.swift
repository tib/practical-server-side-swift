import Leaf

extension UserModel: FormFieldStringOptionRepresentable {

    var formFieldStringOption: FormFieldStringOption {
        .init(key: id!.uuidString, label: email)
    }
}
