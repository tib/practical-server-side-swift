import Foundation

struct TextFieldView: FormFieldView {

    let type: FormFieldType = .text
    
    //...
    
    enum Format: String, Codable {
        case text
        case password
        case email
        case number
    }

    var key: String
    var required: Bool
    var error: String?
    var value: String?
    var label: String?
    var placeholder: String?
    var more: String?
    var format: Format
    
    init(key: String,
         required: Bool = false,
         error: String? = nil,
         value: String? = nil,
         label: String? = nil,
         placeholder: String? = nil,
         more: String? = nil,
         format: Format = .text)
    {
        self.key = key
        self.required = required
        self.error = error
        self.value = value
        self.label = label
        self.placeholder = placeholder
        self.more = more
        self.format = format
    }
}
