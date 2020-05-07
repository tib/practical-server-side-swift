import Vapor

protocol ValidatableContent: Content, Validatable {
    
}

extension ValidatableContent {
    static func validations(_ validations: inout Validations) {}
}

