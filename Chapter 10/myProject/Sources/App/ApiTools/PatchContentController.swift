import Vapor
import Fluent

protocol PatchContentController: IdentifiableContentController
    where Model: PatchContentRepresentable
{
    func patch(_ req: Request) throws -> EventLoopFuture<Model.GetContent>
    func setupPatchRoute(routes: RoutesBuilder)
}

extension PatchContentController {
    
    func patch(_ req: Request) throws -> EventLoopFuture<Model.GetContent> {
        try Model.PatchContent.validate(content: req)
        let input = try req.content.decode(Model.PatchContent.self)
        return try find(req).flatMapThrowing { model -> Model in
            try model.patch(input)
            return model
        }
        .flatMap { model -> EventLoopFuture<Model.GetContent> in
             model.update(on: req.db) .transform(to: model.getContent)
        }
    }
    
    func setupPatchRoute(routes: RoutesBuilder) {
        routes.patch(idPathComponent, use: patch)
    }
}

