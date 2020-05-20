import ContentApi
import MyProjectApi

extension BlogCategoryListObject: Content {}
extension BlogCategoryGetObject: Content {}
extension BlogCategoryCreateObject: ValidatableContent {
    public static func validations(_ validations: inout Validations) {
        validations.add("title", as: String.self, is: !.empty)
    }
}
extension BlogCategoryUpdateObject: ValidatableContent {
    public static func validations(_ validations: inout Validations) {
        validations.add("title", as: String.self, is: !.empty)
    }
}
extension BlogCategoryPatchObject: ValidatableContent {
    public static func validations(_ validations: inout Validations) {
        validations.add("title", as: String.self, is: !.empty)
    }
}
extension BlogCategoryModel: ListContentRepresentable {
    var listContent: BlogCategoryListObject {
        .init(id: self.id!, title: self.title)
    }
}
extension BlogCategoryModel: GetContentRepresentable {
    var getContent: BlogCategoryGetObject {
        .init(id: self.id!, title: self.title)
    }
}
extension BlogCategoryModel: CreateContentRepresentable {
    func create(_ content: BlogCategoryCreateObject) throws {
        self.title = content.title
    }
}
extension BlogCategoryModel: UpdateContentRepresentable {
    func update(_ content: BlogCategoryUpdateObject) throws {
        self.title = content.title
    }
}
extension BlogCategoryModel: PatchContentRepresentable {
    func patch(_ content: BlogCategoryPatchObject) throws {
        self.title = content.title
    }
}
extension BlogCategoryModel: DeleteContentRepresentable {}
