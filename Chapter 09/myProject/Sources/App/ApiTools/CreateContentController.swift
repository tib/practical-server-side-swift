import Vapor
import Fluent

protocol CreateContentController: ContentController
    where Model: CreateContentRepresentable
{
    func create(_ req: Request) throws -> EventLoopFuture<Model.GetContent>
    func setupCreateRoute(routes: RoutesBuilder)
}

extension CreateContentController {
    
    func create(_ req: Request) throws -> EventLoopFuture<Model.GetContent> {
        try Model.CreateContent.validate(req)
        let input = try req.content.decode(Model.CreateContent.self)
        let model = Model()
        try model.create(input)
        return model.create(on: req.db)
            .transform(to: model.getContent)
    }

    func setupCreateRoute(routes: RoutesBuilder) {
        routes.post(use: self.create)
    }
}
