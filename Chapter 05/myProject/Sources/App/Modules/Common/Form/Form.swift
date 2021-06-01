import Foundation

struct Form: Encodable {

    public struct Action: Encodable {
        public enum Method: String, Encodable {
            case get
            case post
        }
        public var method: Method
        public var url: String?
        public var multipart: Bool
        
        public init(method: Method = .post,
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

    public init(action: Action = .init(),
                error: String? = nil,
                fields: [TextFieldView] = [],
                submit: String? = nil) {
        
        self.action = action
        self.error = error
        self.fields = fields
        self.submit = submit
    }
    
}
