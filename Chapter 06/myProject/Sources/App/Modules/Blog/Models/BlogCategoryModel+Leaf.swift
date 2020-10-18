import Leaf

extension BlogCategoryModel: LeafDataRepresentable {

    var leafData: LeafData {
        .dictionary([
            "id": .string(id?.uuidString),
            "title": .string(title),
        ])
    }
}
