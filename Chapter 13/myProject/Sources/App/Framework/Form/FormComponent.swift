import Vapor

public protocol FormComponent {
    
    func load(req: Request) async throws
    func process(req: Request) async throws
    func validate(req: Request) async throws -> Bool
    func write(req: Request) async throws
    func save(req: Request) async throws
    func read(req: Request) async throws
    func render(req: Request) -> TemplateRepresentable
}
