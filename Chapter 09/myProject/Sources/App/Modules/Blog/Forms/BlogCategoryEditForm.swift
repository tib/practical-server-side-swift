import Vapor
import Leaf

final class BlogCategoryEditForm: Form {

    typealias Model = BlogCategoryModel
    
    struct Input: Decodable {
        var id: String
        var title: String
    }

    var id: String? = nil
    var title = StringFormField()

    var leafData: LeafData {
        .dictionary([
            "id": .string(id),
            "title": title.leafData,
        ])
    }

    init() {}

    init(req: Request) throws {
        let context = try req.content.decode(Input.self)
        if !context.id.isEmpty {
            id = context.id
        }
        title.value = context.title
    }
    
    func validate(req: Request) -> EventLoopFuture<Bool> {
        var valid = true
        
        if title.value.isEmpty {
            title.error = "Title is required"
            valid = false
        }
        return req.eventLoop.future(valid)
    }
    
    func read(from model: Model)  {
        id = model.id!.uuidString
        title.value = model.title
    }
    
    func write(to model: Model) {
        model.title = title.value
    }
}
