import Vapor
import Fluent

protocol CreateContentController: ContentController
    where Model: CreateContentRepresentable
{
    func beforeCreate(req: Request, model: Model, content: Model.CreateContent) -> EventLoopFuture<Model>
    func create(_ req: Request) throws -> EventLoopFuture<Model.GetContent>
    func setupCreateRoute(routes: RoutesBuilder)
}

extension CreateContentController {
    
    func beforeCreate(req: Request, model: Model, content: Model.CreateContent) -> EventLoopFuture<Model> {
        req.eventLoop.future(model)
    }
    
    func create(_ req: Request) throws -> EventLoopFuture<Model.GetContent> {
        try Model.CreateContent.validate(content: req)
        let input = try req.content.decode(Model.CreateContent.self)
        let model = Model()
        return beforeCreate(req: req, model: model, content: input).flatMap { model in
            do {
                try model.create(input)
                return model.create(on: req.db).transform(to: model.getContent)
            }
            catch {
                return req.eventLoop.future(error: error)
            }
        }
    }

    func setupCreateRoute(routes: RoutesBuilder) {
        routes.post(use: create)
    }
}
