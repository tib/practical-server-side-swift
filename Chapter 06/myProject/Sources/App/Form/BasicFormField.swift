import Foundation
import Leaf

struct BasicFormField: LeafDataRepresentable {
    var value: String = ""
    var error: String?

    var leafData: LeafData {
        .dictionary([
            "value": .string(value),
            "error": .string(error),
        ])
    }
}

