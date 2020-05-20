import Foundation

struct FileFormField: Encodable {
    var value: String = ""
    var error: String? = nil
    var data: Data? = nil
    var delete: Bool = false
}
