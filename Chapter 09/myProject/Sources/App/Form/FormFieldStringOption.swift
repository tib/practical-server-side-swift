import Leaf

struct FormFieldStringOption: LeafDataRepresentable {

    let key: String
    let label: String

    var leafData: LeafData {
        .dictionary([
            "key": .string(key),
            "label": .string(label),
        ])
    }
}
