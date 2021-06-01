import Foundation
import Vapor

final class UserLoginForm: Form {

    init() {
        super.init()
        
        action.url = "/sign-in/"
        submit = "Sign in"

        let emailField = TextField(key: "email")
        emailField.output.required = true
        emailField.output.format = .email
        
        let passwordField = TextField(key: "password")
        passwordField.output.required = true
        passwordField.output.format = .password
        
        self.fields = [
            emailField,
            passwordField,
        ]
    }
}
