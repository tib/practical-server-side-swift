import Foundation

struct ImageFieldView: FormFieldView {
    
    let type: FormFieldType = .image
    
    var key: String
    var required: Bool
    var error: String?
    
    var label: String?
    var more: String?
    
    var accept: String?
    var currentKey: String?
    var temporaryKey: String?
    var temporaryName: String?
    var remove: Bool
    
    init(key: String,
         required: Bool = false,
         error: String? = nil,
         label: String? = nil,
         more: String? = nil,
         accept: String? = nil,
         currentKey: String? = nil,
         temporaryKey: String? = nil,
         temporaryName: String? = nil,
         remove: Bool = false) {
        self.key = key
        self.required = required
        self.error = error
        self.label = label
        self.more = more
        self.accept = accept
        self.currentKey = currentKey
        self.temporaryKey = temporaryKey
        self.temporaryName = temporaryName
        self.remove = remove
    }
}


