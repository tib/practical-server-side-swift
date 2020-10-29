import Leaf

struct StringFormField: LeafDataRepresentable {

    var value: String = ""
    var error: String? = nil

    var leafData: LeafData {
        .dictionary([
            "value": .string(value),
            "error": .string(error),
        ])
    }
}
