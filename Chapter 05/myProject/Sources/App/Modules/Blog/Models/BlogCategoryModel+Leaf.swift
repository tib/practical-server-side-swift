import Leaf

extension BlogCategoryModel {

    var viewContext: LeafData {
        .dictionary([
            "id": .string(id!.uuidString),
            "title": .string(title),
        ])
    }
}

