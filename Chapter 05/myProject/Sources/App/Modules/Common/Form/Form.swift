import Foundation

struct Form: Encodable {
    
    struct Action: Encodable {
        enum Method: String, Encodable {
            case get
            case post
        }
        var method: Method
        var url: String?
        var multipart: Bool
        
        init(method: Method = .post,
             url: String? = nil,
             multipart: Bool = false) {
            self.method = method
            self.url = url
            self.multipart = multipart
        }
    }
    
    var action: Action
    var error: String?
    var fields: [TextFieldView]
    var submit: String?
    
    init(action: Action = .init(),
         error: String? = nil,
         fields: [TextFieldView] = [],
         submit: String? = nil) {
        
        self.action = action
        self.error = error
        self.fields = fields
        self.submit = submit
    }
    
}
