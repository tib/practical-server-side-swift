import Vapor
import Fluent

protocol GetContentController: IdentifiableContentController
    where Model: GetContentRepresentable
{
    func get(_: Request) throws -> EventLoopFuture<Model.GetContent>
    func setupGetRoute(routes: RoutesBuilder)
}

extension GetContentController {
    func get(_ req: Request) throws -> EventLoopFuture<Model.GetContent> {
        try find(req).map(\.getContent)
    }

    func setupGetRoute(routes: RoutesBuilder) {
        routes.get(idPathComponent, use: get)
    }
}
