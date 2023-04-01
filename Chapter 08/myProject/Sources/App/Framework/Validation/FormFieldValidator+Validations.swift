import Vapor

public extension FormFieldValidator where Input == String {

    static func required(
        _ field: AbstractFormField<Input, Output>,
        _ message: String? = nil
    ) -> FormFieldValidator<Input, Output> {
        let msg = message ??
            "\(field.key.capitalized) is required"
        return .init(field, msg) { _, field in
            !field.input.isEmpty
        }
    }
    
    static func min(
        _ field: AbstractFormField<Input, Output>,
        length: Int,
        message: String? = nil
    ) -> FormFieldValidator<Input, Output> {
        let msg = message ??
            "\(field.key.capitalized) is too short (min: \(length) characters)"
        return .init(field, msg) { _, field in
            field.input.count >= length
        }
    }
    
    static func max(
        _ field: AbstractFormField<Input, Output>,
        length: Int,
        message: String? = nil
    ) -> FormFieldValidator<Input, Output> {
        let msg = message ??
            "\(field.key.capitalized) is too short (min: \(length) characters)"
        return .init(field, msg) { _, field in
            field.input.count <= length
        }
    }

    static func alphanumeric(
        _ field: AbstractFormField<Input, Output>,
        message: String? = nil
    ) -> FormFieldValidator<Input, Output> {
        let msg = message ??
            "\(field.key.capitalized) should be only alphanumeric characters"
        return .init(field, msg) { _, field in
            !Validator
                .characterSet(.alphanumerics)
                .validate(field.input)
                .isFailure
        }
    }

    static func email(
        _ field: AbstractFormField<Input, Output>,
        message: String? = nil
    ) -> FormFieldValidator<Input, Output> {
        let msg = message ??
            "\(field.key.capitalized) should be a valid email address"
        return .init(field, msg) { _, field in
            !Validator
                .email
                .validate(field.input)
                .isFailure
        }
    }
}
