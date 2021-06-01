import Foundation
import Vapor

open class FormField<Input: Decodable, Output: Encodable>: FormComponent {

    var key: String
    var input: Input
    var output: Output

    init(key: String, input: Input, output: Output) {
        self.key = key
        self.input = input
        self.output = output
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(output)
    }
    
    // MARK: - component api
        
    open func load(req: Request) -> EventLoopFuture<Void> {
        req.eventLoop.future()
    }

    open func process(req: Request) -> EventLoopFuture<Void> {
        if let value = try? req.content.get(Input.self, at: key) {
            input = value
        }
        return req.eventLoop.future()
    }

    open func validate(req: Request) -> EventLoopFuture<Bool> {
        req.eventLoop.future(true)
    }
    
    open func write(req: Request) -> EventLoopFuture<Void> {
        req.eventLoop.future()
    }

    open func save(req: Request) -> EventLoopFuture<Void> {
        req.eventLoop.future()
    }
    
    open func read(req: Request) -> EventLoopFuture<Void> {
        req.eventLoop.future()
    }
}
