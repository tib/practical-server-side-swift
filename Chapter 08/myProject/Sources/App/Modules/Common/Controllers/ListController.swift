import Foundation
import Vapor
import Fluent

protocol ListController: ModelController {
    func listView(req: Request) throws -> EventLoopFuture<View>
    
    func listTable(_ models: [Model]) -> Table
    func listContext(req: Request, table: Table) -> ListContext
}

public struct ListContext: Encodable {

    public let title: String
    public let table: Table

    internal init(title: String, table: Table) {
        self.title = title
        self.table = table
    }
}


extension ListController {

    func listView(req: Request) throws -> EventLoopFuture<View> {
        Model.query(on: req.db)
            .all()
            .map { listTable($0) }
            .flatMap { table in
                req.view.render("Common/List", listContext(req: req, table: table))
            }
    }
    
    
}
