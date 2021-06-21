import Vapor
import Fluent

protocol EditForm: FormComponent {
    associatedtype Model: Fluent.Model

    var context: FormContext<Model> { get set }

    init()
}

extension EditForm {

    func encode(to encoder: Encoder) throws {
        try context.encode(to: encoder)
    }
    
    func load(req: Request) -> EventLoopFuture<Void> {
        return context.load(req: req)
    }
    
    func process(req: Request) -> EventLoopFuture<Void> {
        context.process(req: req)
    }
    
    func validate(req: Request) -> EventLoopFuture<Bool> {
        context.validate(req: req)
    }
    
    func write(req: Request) -> EventLoopFuture<Void> {
        context.write(req: req)
    }
    
    func save(req: Request) -> EventLoopFuture<Void> {
        context.save(req: req)
    }
    
    func read(req: Request) -> EventLoopFuture<Void> {
        context.read(req: req)
    }
}
