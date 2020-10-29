import Vapor
import Fluent

protocol UpdateContentController: IdentifiableContentController
    where Model: UpdateContentRepresentable
{
    func beforeUpdate(req: Request, model: Model, content: Model.UpdateContent) -> EventLoopFuture<Model>
    func update(_ req: Request) throws -> EventLoopFuture<Model.GetContent>
    func setupUpdateRoute(routes: RoutesBuilder)
}

extension UpdateContentController {
    
    func beforeUpdate(req: Request, model: Model, content: Model.UpdateContent) -> EventLoopFuture<Model> {
        req.eventLoop.future(model)
    }

    func update(_ req: Request) throws -> EventLoopFuture<Model.GetContent> {
        try Model.UpdateContent.validate(content: req)
        let input = try req.content.decode(Model.UpdateContent.self)
        return try find(req)
        .flatMap { model in
            beforeUpdate(req: req, model: model, content: input)
        }
        .flatMapThrowing { model -> Model in
            try model.update(input)
            return model
        }
        .flatMap { model -> EventLoopFuture<Model.GetContent> in
             return model.update(on: req.db)
                .transform(to: model.getContent)
        }
    }
    
    func setupUpdateRoute(routes: RoutesBuilder) {
        routes.put(idPathComponent, use: update)
    }
}
