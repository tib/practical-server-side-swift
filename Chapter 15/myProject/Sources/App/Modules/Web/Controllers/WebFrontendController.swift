import Vapor

struct WebFrontendController {
    
    func anyResponse(
        _ req: Request
    ) async throws -> Response {
        let result: [Response?] = try await req.invokeAllAsync("response")
        guard let response = result.compactMap({ $0 }).first else {
            throw Abort(.notFound)
        }
        return response
    }
    
    func homeView(req: Request) throws -> Response {
        let ctx = WebHomeContext(
            icon: "👋",
            title: "Home",
            message: "Hi there, welcome to my page.",
            paragraphs: [
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
                "Nisi ut aliquip ex ea commodo consequat.",
            ],
            link: .init(
                label: "Read my blog →",
                url: "/blog/"
            )
        )
        
        return req.templates.renderHtml(
            WebHomeTemplate(ctx)
        )
    }
}
