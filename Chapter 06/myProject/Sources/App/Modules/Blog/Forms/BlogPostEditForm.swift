import Foundation
import Vapor

final class BlogPostEditForm: Form {

    init() {
        super.init()
        
        let titleField = TextField(key: "title")
        titleField.output.required = true
        
        let slugField = TextField(key: "slug")
        slugField.output.required = true
        
        let excerptField = TextareaField(key: "excerpt")
        excerptField.output.required = true
        excerptField.output.size = .s
        
        let dateField = TextField(key: "date")
        dateField.output.required = true
        
        let contentField = TextareaField(key: "content")
        contentField.output.required = true
        contentField.output.size = .l

        self.fields = [
            titleField,
            slugField,
            excerptField,
            dateField,
            contentField,
        ]
    }
}
