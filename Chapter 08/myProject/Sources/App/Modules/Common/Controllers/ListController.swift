import Foundation
import Vapor
import Fluent

protocol ListController: ModelController {
    func listView(req: Request) throws -> EventLoopFuture<View>
    
    func listTable(_ models: [Model]) -> Table
}

extension ListController {

    func listView(req: Request) throws -> EventLoopFuture<View> {
        Model.query(on: req.db)
            .all()
            .map { listTable($0) }
            .flatMap { table in
                req.tau.render(template: "Common/Table", context: [
                    "table": table.encodeToTemplateData()
                ])
            }
    }
    
    
}
