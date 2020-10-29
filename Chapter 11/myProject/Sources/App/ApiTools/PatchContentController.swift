import Vapor
import Fluent

protocol PatchContentController: IdentifiableContentController
    where Model: PatchContentRepresentable
{
    func beforePatch(req: Request, model: Model, content: Model.PatchContent) -> EventLoopFuture<Model>
    func patch(_ req: Request) throws -> EventLoopFuture<Model.GetContent>
    func setupPatchRoute(routes: RoutesBuilder)
}

extension PatchContentController {
    
    func beforePatch(req: Request, model: Model, content: Model.PatchContent) -> EventLoopFuture<Model> {
        req.eventLoop.future(model)
    }
    
    func patch(_ req: Request) throws -> EventLoopFuture<Model.GetContent> {
        try Model.PatchContent.validate(content: req)
        let patch = try req.content.decode(Model.PatchContent.self)
        return try find(req)
        .flatMap { model in
            beforePatch(req: req, model: model, content: patch)
        }
        .flatMapThrowing { model -> Model in
            try model.patch(patch)
            return model
        }
        .flatMap { model -> EventLoopFuture<Model.GetContent> in
            return model.update(on: req.db)
                .transform(to: model.getContent)
        }
    }
    
    func setupPatchRoute(routes: RoutesBuilder) {
        routes.patch(idPathComponent, use: patch)
    }
}

