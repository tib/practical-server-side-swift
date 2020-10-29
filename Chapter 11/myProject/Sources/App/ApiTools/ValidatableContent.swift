import Vapor

protocol ValidatableContent: Content, Validatable {
    
}

extension ValidatableContent {
    public static func validations(_ validations: inout Validations) {}
}

