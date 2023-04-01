import Vapor

public struct FormFieldValidator<
    Input: Decodable,
    Output: TemplateRepresentable
>: AsyncValidator {
    
    public typealias AsyncValidationBlock =
        ((Request, AbstractFormField<Input, Output>) async throws -> Bool)

    public let field: AbstractFormField<Input, Output>
    public let message: String
    public let validation: AsyncValidationBlock
    
    public var key: String { field.key }
    
    public init(
        _ field: AbstractFormField<Input, Output>,
        _ message: String,
        _ validation: @escaping AsyncValidationBlock
    ) {
        self.field = field
        self.message = message
        self.validation = validation
    }
    
    public func validate(
        _ req: Request
    ) async throws -> ValidationErrorDetail? {
        let isValid = try await validation(req, field)
        if isValid {
            return nil
        }
        field.error = message
        return error
    }
}
