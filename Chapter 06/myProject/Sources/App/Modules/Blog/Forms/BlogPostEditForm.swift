import Foundation

final class BlogPostEditForm: Form {

    init() {
        super.init()

        self.fields = [
            TextFieldView(key: "title", required: true),
            TextFieldView(key: "slug", required: true),
            TextareaFieldView(key: "excerpt", required: true),
            TextFieldView(key: "date", required: true),
            TextareaFieldView(key: "content", required: true),
        ]
    }
}
