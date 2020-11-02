import Leaf

extension BlogCategoryModel: LeafDataRepresentable {

    var leafData: LeafData {
        .dictionary([
            "id": .string(id?.uuidString),
            "title": .string(title),
        ])
    }
}

extension BlogCategoryModel: FormFieldStringOptionRepresentable {
    var formFieldStringOption: FormFieldStringOption {
        .init(key: id!.uuidString, label: title)
    }
}
