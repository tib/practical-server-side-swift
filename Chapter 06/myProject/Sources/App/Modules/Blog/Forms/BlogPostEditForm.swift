import Foundation
import Vapor

final class BlogPostEditForm: Form {

    var model: BlogPostModel?

    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()

    init() {
        super.init()

        self.fields = [
            TextField(key: "title")
                .config { $0.output.required = true }
                .read { [unowned self] in $1.output.value = model?.title }
                .write { [unowned self] in model?.title = $1.input },
                
            TextField(key: "slug")
                .config { $0.output.required = true }
                .read { [unowned self] in $1.output.value = model?.slug }
                .write { [unowned self] in model?.slug = $1.input },
            
            TextareaField(key: "excerpt")
                .config {
                    $0.output.required = true
                    $0.output.size = .s
                }
                .read { [unowned self] in $1.output.value = model?.excerpt }
                .write { [unowned self] in model?.excerpt = $1.input },
            
            TextField(key: "date")
                .config { [unowned self] in
                    $0.output.required = true
                    $0.output.value = formatter.string(from: Date())
                }
                .read { [unowned self] in $1.output.value = formatter.string(from: model?.date ?? Date()) }
                .write { [unowned self] in model?.date = formatter.date(from: $1.input) ?? Date() },
                
            TextareaField(key: "content")
                .config {
                    $0.output.required = true
                    $0.output.size = .l
                }
                .read { [unowned self] in $1.output.value = model?.content }
                .write { [unowned self] in model?.content = $1.input },
        ]
    }
    
    // ...
    override func write(req: Request) -> EventLoopFuture<Void> {
        super.write(req: req)
            .flatMap { [unowned self] in
                if let _ = req.parameters.get("id") {
                    return req.eventLoop.future()
                }
                model?.image = "/img/posts/01.jpg"
                return BlogCategoryModel.query(on: req.db).first().map {
                    model?.$category.id = $0!.id!
                }
        }
    }
}
