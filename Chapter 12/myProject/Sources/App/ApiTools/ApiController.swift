import Vapor

protocol ApiController:
    ListContentController,
    GetContentController,
    CreateContentController,
    UpdateContentController,
    PatchContentController,
    DeleteContentController
{
    func setupRoutes(routes: RoutesBuilder, on pathComponent: PathComponent)
}

extension ApiController {

    func setupRoutes(routes: RoutesBuilder, on pathComponent: PathComponent) {
        let modelRoutes = routes.grouped(pathComponent)
        setupListRoute(routes: modelRoutes)
        setupGetRoute(routes: modelRoutes)
        setupCreateRoute(routes: modelRoutes)
        setupUpdateRoute(routes: modelRoutes)
        setupPatchRoute(routes: modelRoutes)
        setupDeleteRoute(routes: modelRoutes)
    }
}
