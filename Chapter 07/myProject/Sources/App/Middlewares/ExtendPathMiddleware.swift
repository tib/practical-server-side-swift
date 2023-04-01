import Vapor

struct ExtendPathMiddleware: AsyncMiddleware {

    func respond(
        to req: Request,
        chainingTo next: AsyncResponder
    ) async throws -> Response {
        if !req.url.path.hasSuffix("/") && !req.url.path.contains(".") {
            return req.redirect(
                to: req.url.path + "/",
                redirectType: .permanent
            )
        }
        return try await next.respond(
            to: req
        )
    }
}
