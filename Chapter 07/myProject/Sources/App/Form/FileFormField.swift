import Foundation
import Leaf

struct FileFormField: LeafDataRepresentable {

    var value: String = ""
    var error: String? = nil
    var data: Data? = nil
    var delete: Bool = false

    var leafData: LeafData {
        .dictionary([
            "value": .string(value),
            "error": .string(error),
            "data": .data(data),
            "delete": .bool(delete),
        ])
    }
}
