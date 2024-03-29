import Vapor

protocol AdminController:
    AdminListController,
    AdminDetailController,
    AdminCreateController,
    AdminUpdateController,
    AdminDeleteController
{
    func setupRoutes(
        _ routes: RoutesBuilder
    )
}

extension AdminController {
    
    func setupRoutes(
        _ routes: RoutesBuilder
    ) {
        setupListRoutes(routes)
        setupDetailRoutes(routes)
        setupCreateRoutes(routes)
        setupUpdateRoutes(routes)
        setupDeleteRoutes(routes)
    }
}
