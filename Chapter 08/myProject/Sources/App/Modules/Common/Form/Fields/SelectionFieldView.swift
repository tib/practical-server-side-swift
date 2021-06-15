import Foundation

struct SelectionFieldView: FormFieldView {
    
    let type: FormFieldType = .selection
    
    var key: String
    var required: Bool
    var error: String?
    
    var value: String?
    
    var options: [FormFieldOption]
    
    var label: String?
    var more: String?
    
    init(key: String,
         required: Bool = false,
         error: String? = nil,
         value: String? = nil,
         options: [FormFieldOption] = [],
         label: String? = nil,
         more: String? = nil) {
        self.key = key
        self.required = required
        self.error = error
        self.value = value
        self.options = options
        self.label = label
        self.more = more
    }
}

