//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 07..
//

import Vapor

struct ApiErrorMiddleware: AsyncMiddleware {

    func respond(to req: Request, chainingTo next: AsyncResponder) async throws -> Response {
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
                message = req.application.environment.isRelease ? "Something went wrong." : error.localizedDescription
                details = []
            }

            req.logger.report(error: error)

            let response = Response(status: status, headers: headers)

            do {
                response.body = try .init(data: JSONEncoder().encode(ValidationError(message: message, details: details)))
                response.headers.replaceOrAdd(name: .contentType, value: "application/json; charset=utf-8")
            }
            catch {
                response.body = .init(string: "Oops: \(error)")
                response.headers.replaceOrAdd(name: .contentType, value: "text/plain; charset=utf-8")
            }
            return response
        }
    }
}
