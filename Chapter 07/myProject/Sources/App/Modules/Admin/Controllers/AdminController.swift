import Vapor

struct AdminController {

    func dashboardView(req: Request) throws -> EventLoopFuture<View> {
        // try req.auth.require(UserModel.self)
        req.view.render("Admin/Dashboard")
    }
}
