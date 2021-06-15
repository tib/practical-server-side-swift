import Foundation
import Vapor

struct RequestValidator {

    var validators: [AsyncValidator]
    
    init(_ validators: [AsyncValidator] = []) {
        self.validators = validators
    }
    
    func validate(_ req: Request, message: String? = nil) -> EventLoopFuture<Void> {
        let initial: EventLoopFuture<[ValidationErrorDetail]> = req.eventLoop.future([])
        return validators.reduce(initial) { res, next -> EventLoopFuture<[ValidationErrorDetail]> in
            return res.flatMap { arr -> EventLoopFuture<[ValidationErrorDetail]> in
                if arr.contains(where: { $0.key == next.key }) {
                    return req.eventLoop.future(arr)
                }
                return next.validate(req).map { result in
                    if let result = result {
                        return arr + [result]
                    }
                    return arr
                }
            }
        }
        .flatMap { details -> EventLoopFuture<Void> in
            guard details.isEmpty else {
                return req.eventLoop.future(error: Abort(.badRequest, reason: message))
            }
            return req.eventLoop.future()
        }
    }

    func isValid(_ req: Request) -> EventLoopFuture<Bool> {
        return validate(req).map { true }.recover { _ in false }
    }
}





