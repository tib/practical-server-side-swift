import Foundation

struct SelectionFormField: Encodable {
    var value: String = ""
    var error: String? = nil
    var options: [FormFieldOption] = []
}
