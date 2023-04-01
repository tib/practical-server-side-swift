import Vapor

public protocol AsyncValidator {
    
    var key: String { get }
    var message: String { get }

    func validate(
        _ req: Request
    ) async throws -> ValidationErrorDetail?
}

public extension AsyncValidator {

    var error: ValidationErrorDetail {
        .init(key: key, message: message)
    }
}
