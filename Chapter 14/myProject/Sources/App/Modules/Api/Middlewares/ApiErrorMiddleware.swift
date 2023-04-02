import Vapor

struct ApiErrorMiddleware: AsyncMiddleware {
    
    func respond(
        to req: Request,
        chainingTo next: AsyncResponder
    ) async throws -> Response {
        do {
            return try await next.respond(to: req)
        }
        catch {
            let status: HTTPResponseStatus
            let headers: HTTPHeaders
            let message: String?
            let details: [ValidationErrorDetail]
            
            switch error {
            case let abort as ValidationAbort:
                status = abort.abort.status
                headers = abort.abort.headers
                message = abort.message
                details = abort.details
            case let abort as Abort:
                status = abort.status
                headers = abort.headers
                message = abort.reason
                details = []
            default:
                status = .internalServerError
                headers = [:]
                if req.application.environment.isRelease {
                    message = "Something went wrong."
                }
                else {
                    message = error.localizedDescription
                }
                details = []   
            }
            
            req.logger.report(error: error)
            
            let response = Response(
                status: status,
                headers: headers
            )
            
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(
                    ValidationError(
                        message: message,
                        details: details
                    )
                )
                response.body = .init(data: data)
                response.headers.replaceOrAdd(
                    name: .contentType,
                    value: "application/json; charset=utf-8"
                )
            }
            catch {
                response.body = .init(string: "Oops: \(error)")
                response.headers.replaceOrAdd(
                    name: .contentType,
                    value: "text/plain; charset=utf-8"
                )
            }
            return response
        }
    }
}
