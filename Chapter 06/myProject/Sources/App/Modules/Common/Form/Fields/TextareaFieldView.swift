import Foundation

struct TextareaFieldView: FormFieldView {
    
    enum Size: String, Codable {
        case xs, s, normal, l, xl
    }
    
    let type: FormFieldType = .textarea
    
    var key: String
    var required: Bool
    var error: String?
    
    var value: String?
    
    var label: String?
    var placeholder: String?
    var more: String?
    
    var size: Size
    
    init(key: String,
         required: Bool = false,
         error: String? = nil,
         value: String? = nil,
         label: String? = nil,
         placeholder: String? = nil,
         more: String? = nil,
         size: Size = .normal) {
        self.key = key
        self.required = required
        self.error = error
        self.value = value
        self.label = label
        self.placeholder = placeholder
        self.more = more
        self.size = size
    }
}

