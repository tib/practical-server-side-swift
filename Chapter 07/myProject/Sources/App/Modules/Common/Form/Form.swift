import Foundation
import Vapor

open class Form: FormComponent {

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
    var fields: [FormComponent]
    var submit: String?

    init(action: Action = .init(),
                error: String? = nil,
                fields: [FormComponent] = [],
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
    
    // MARK: - form component
    
    open func load(req: Request) -> EventLoopFuture<Void> {
        return req.eventLoop.flatten(fields.map { $0.load(req: req) })
    }

    open func process(req: Request) -> EventLoopFuture<Void> {
        req.eventLoop.flatten(fields.map { $0.process(req: req) })
    }

    open func validate(req: Request) -> EventLoopFuture<Bool> {
        return req.eventLoop.mergeTrueFutures(fields.map { $0.validate(req: req) })
    }

    open func save(req: Request) -> EventLoopFuture<Void> {
        req.eventLoop.flatten(fields.map { $0.save(req: req) })
    }
    
    open func read(req: Request) -> EventLoopFuture<Void> {
        req.eventLoop.flatten(fields.map { $0.read(req: req) })
    }

    open func write(req: Request) -> EventLoopFuture<Void> {
        req.eventLoop.flatten(fields.map { $0.write(req: req) })
    }
    
}
