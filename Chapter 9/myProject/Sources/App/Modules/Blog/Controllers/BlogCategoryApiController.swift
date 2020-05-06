import Vapor
import Fluent

struct BlogCategoryApiController:
    ListContentController,
    GetContentController,
    CreateContentController,
    UpdateContentController,
    PatchContentController,
    DeleteContentController
{
    typealias Model = BlogCategoryModel
}
