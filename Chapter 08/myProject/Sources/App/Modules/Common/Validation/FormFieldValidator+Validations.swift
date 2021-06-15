import Foundation
import Vapor

extension FormFieldValidator where Input == String {

    static func required(_ field: FormField<Input, Output>, _ message: String? = nil) -> FormFieldValidator<Input, Output> {
        .init(field, message ?? "\(field.key.capitalized) is required") { !$0.input.isEmpty }
    }
    
    static func min(_ field: FormField<Input, Output>, length: Int, message: String? = nil) -> FormFieldValidator<Input, Output> {
        let msg = message ?? "\(field.key.capitalized) is too short (min: \(length) characters)"
        return .init(field, msg) { $0.input.count >= length }
    }
    
    static func max(_ field: FormField<Input, Output>, length: Int, message: String? = nil) -> FormFieldValidator<Input, Output> {
        let msg = message ?? "\(field.key.capitalized) is too short (min: \(length) characters)"
        return .init(field, msg) { $0.input.count <= length }
    }

    static func alphanumeric(_ field: FormField<Input, Output>, message: String? = nil) -> FormFieldValidator<Input, Output> {
        let msg = message ?? "\(field.key.capitalized) should be only alphanumeric characters"
        return .init(field, msg) { Validator.characterSet(.alphanumerics).validate($0.input).isFailure }
    }

    static func email(_ field: FormField<Input, Output>, message: String? = nil) -> FormFieldValidator<Input, Output> {
        let msg = message ?? "\(field.key.capitalized) should be a valid email address"
        return .init(field, msg) { Validator.email.validate($0.input).isFailure }
    }
}
