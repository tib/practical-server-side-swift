import Vapor
import Fluent

protocol GetController: ModelController {
    
}

extension GetController {

    func find(_ req: Request) throws -> EventLoopFuture<Model> {
        guard
            let id = req.parameters.get(Model.idParamKey),
            let uuid = UUID(uuidString: id)
        else {
            throw Abort(.notFound)
        }
        return Model.find(uuid, on: req.db).unwrap(or: Abort(.notFound))
    }
}
