import Foundation

open class Form: Encodable {

    enum CodingKeys: CodingKey {
        case action
        case id
        case token
        case title
        case notification
        case error
        case fields
        case submit
    }
    
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
    var fields: [FormFieldView]
    var submit: String?

    init(action: Action = .init(),
                error: String? = nil,
                fields: [FormFieldView] = [],
                submit: String? = nil) {
        
        self.action = action
        self.error = error
        self.fields = fields
        self.submit = submit
    }
    
    // MARK: - encodable
    
    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(action, forKey: .action)
        try container.encodeIfPresent(error, forKey: .error)
        try container.encodeIfPresent(submit, forKey: .submit)

        var fieldsArrayContainer = container.superEncoder(forKey: .fields).unkeyedContainer()
        for field in fields {
            try field.encode(to: fieldsArrayContainer.superEncoder())
        }
    }
    
}
