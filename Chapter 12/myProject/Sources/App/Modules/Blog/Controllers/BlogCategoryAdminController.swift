import Vapor
import Fluent
import Leaf

struct BlogCategoryAdminController: AdminViewController {
    typealias Module = BlogModule
    typealias Model = BlogCategoryModel
    typealias EditForm = BlogCategoryEditForm
}
