import Foundation

struct FormFieldOption: Encodable {
    
    let key: String
    let label: String
    
    init(key: String, label: String) {
        self.key = key
        self.label = label
    }
}
