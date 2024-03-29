import Vapor
import SwiftHtml

struct BlogAdminWidgetTemplate: TemplateRepresentable {
    
    @TagBuilder
    func render(_ req: Request) -> Tag {
        H2("Blog")
        Ul {
            Li {
                A("Posts")
                    .href("/admin/blog/posts/")
            }
            Li {
                A("Categories")
                    .href("/admin/blog/categories/")
            }
        }
    }
}
