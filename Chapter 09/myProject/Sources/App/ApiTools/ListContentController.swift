import Vapor
import Fluent

protocol ListContentController: ContentController
    where Model: ListContentRepresentable
{
    func list(_: Request) throws -> EventLoopFuture<Page<Model.ListItem>>
    func setupListRoute(routes: RoutesBuilder)
}

extension ListContentController {

    func list(_ req: Request) throws -> EventLoopFuture<Page<Model.ListItem>> {
        Model.query(on: req.db).paginate(for: req).map { $0.map(\.listContent) }
    }
    
    func setupListRoute(routes: RoutesBuilder) {
        routes.get(use: list)
    }
}
