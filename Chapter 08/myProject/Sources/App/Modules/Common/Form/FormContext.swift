import Vapor
import Fluent

open class FormContext<T: ModelInterface>: FormComponent {
    
    fileprivate enum CodingKeys: String, CodingKey {
        case name
        case form
    }
    
    var name: String
    var form: Form
    
    var model: T?
    

    init(form: Form = .init(), model: T? = nil) {
        self.form = form
        self.model = model
        
        self.name = T.name.singular.capitalized
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(form, forKey: .form)
    }

    // MARK: - form component

    open func load(req: Request) -> EventLoopFuture<Void> {
        form.load(req: req)
    }
    
    open func process(req: Request) -> EventLoopFuture<Void> {
        form.process(req: req)
    }
    
    open func validate(req: Request) -> EventLoopFuture<Bool> {
        form.validate(req: req)
    }
    
    open func write(req: Request) -> EventLoopFuture<Void> {
        form.write(req: req)
    }
    
    open func save(req: Request) -> EventLoopFuture<Void> {
        form.save(req: req)
    }
    
    open func read(req: Request) -> EventLoopFuture<Void> {
        form.read(req: req)
    }
}
