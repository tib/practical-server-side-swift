import Vapor
import Fluent
import Leaf

struct BlogCategoryAdminController: ViperAdminViewController {    
    typealias Module = BlogModule
    typealias Model = BlogCategoryModel
    typealias EditForm = BlogCategoryEditForm
}
