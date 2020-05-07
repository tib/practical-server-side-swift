import Vapor
import Fluent
import ViewKit

struct BlogCategoryAdminController: ViperAdminViewController {

    typealias Module = BlogModule
    typealias EditForm = BlogCategoryEditForm
    typealias Model = BlogCategoryModel
}
