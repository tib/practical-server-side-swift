import Foundation
import Vapor

open class FormField<Input: Decodable, Output: Encodable>: FormComponent {

    public typealias FormFieldBlock = (Request, FormField<Input, Output>) -> Void
    public typealias FormFieldFutureBlock = (Request, FormField<Input, Output>) -> EventLoopFuture<Void>

    var key: String
    var input: Input
    var output: Output
    
    internal var loadBlock: FormFieldFutureBlock?
    internal var processBlock: FormFieldFutureBlock?
    internal var readBlock: FormFieldFutureBlock?
    internal var writeBlock: FormFieldFutureBlock?
    internal var saveBlock: FormFieldFutureBlock?

    
    init(key: String, input: Input, output: Output) {
        self.key = key
        self.input = input
        self.output = output
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(output)
    }
    
    // MARK: - modifiers api
    
    open func config(_ block: (FormField<Input, Output>) -> Void) -> Self {
        block(self)
        return self
    }
    
    open func process(_ block: @escaping FormFieldFutureBlock) -> Self {
        processBlock = block
        return self
    }

    open func load(_ block: @escaping FormFieldBlock) -> Self {
        loadBlock = { req, field in
            block(req, field)
            return req.eventLoop.future()
        }
        return self
    }
    
    open func load(_ block: @escaping FormFieldFutureBlock) -> Self {
        loadBlock = block
        return self
    }
        
    open func write(_ block: @escaping FormFieldBlock) -> Self {
        writeBlock = { req, field in
            block(req, field)
            return req.eventLoop.future()
        }
        return self
    }
    
    open func write(_ block: @escaping FormFieldFutureBlock) -> Self {
        writeBlock = block
        return self
    }

    
    open func save(_ block: @escaping FormFieldBlock) -> Self {
        saveBlock = { req, field in
            block(req, field)
            return req.eventLoop.future()
        }
        return self
    }
    
    open func save(_ block: @escaping FormFieldFutureBlock) -> Self {
        saveBlock = block
        return self
    }
    
    open func read(_ block: @escaping FormFieldBlock) -> Self {
        readBlock = { req, field in
            block(req, field)
            return req.eventLoop.future()
        }
        return self
    }
    
    open func read(_ block: @escaping FormFieldFutureBlock) -> Self {
        readBlock = block
        return self
    }
    
    // MARK: - component api
        
    func load(req: Request) -> EventLoopFuture<Void> {
        loadBlock?(req, self) ?? req.eventLoop.future()
    }

    func process(req: Request) -> EventLoopFuture<Void> {
        if let value = try? req.content.get(Input.self, at: key) {
            input = value
        }
        return processBlock?(req, self) ?? req.eventLoop.future()
    }

    func validate(req: Request) -> EventLoopFuture<Bool> {
        req.eventLoop.future(true)
    }
    
    open func write(req: Request) -> EventLoopFuture<Void> {
        writeBlock?(req, self) ?? req.eventLoop.future()
    }

    func save(req: Request) -> EventLoopFuture<Void> {
        saveBlock?(req, self) ?? req.eventLoop.future()
    }
    
    open func read(req: Request) -> EventLoopFuture<Void> {
        readBlock?(req, self) ?? req.eventLoop.future()
    }
}
