import Foundation
import Vapor

struct FormFieldValidator<Input: Decodable, Output: FormFieldView>: AsyncValidator {
    
    unowned var field: FormField<Input, Output>
    let message: String
    var key: String { field.key }
    
    let validation: ((FormField<Input, Output>) -> Bool)?
    let asyncValidation: ((FormField<Input, Output>, Request) -> EventLoopFuture<Bool>)?
    
    init(_ field: FormField<Input, Output>,
         _ message: String,
         _ validation: ((FormField<Input, Output>) -> Bool)? = nil,
         _ asyncValidation: ((FormField<Input, Output>, Request) -> EventLoopFuture<Bool>)? = nil) {
        self.field = field
        self.message = message
        self.validation = validation
        self.asyncValidation = asyncValidation
    }
    
    func validate(_ req: Request) -> EventLoopFuture<ValidationErrorDetail?> {
        var future: EventLoopFuture<ValidationErrorDetail?> = req.eventLoop.future(nil)
        if let validation = validation {
            future = req.eventLoop.future(validation(field) ? nil : error)
        }
        if let asyncValidation = asyncValidation {
            future = asyncValidation(field, req).map { $0 ? nil : error }
        }
        return future.map { [unowned field] result in
            guard result == nil else {
                field.output.error = message
                return result
            }
            return result
        }
    }
}
