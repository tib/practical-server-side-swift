//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 01..
//

import Vapor

final class UserLoginForm: AbstractForm {
    
    public convenience init() {
        self.init(action: .init(method: .post, url: "/sign-in/"),
                  submit: "Sign in")
        self.fields = createFields()
    }

    func createFields() -> [FormComponent] {
        [
            InputField("email")
                .config {
                    $0.output.context.label.required = true
                    $0.output.context.type = .email
                },
            InputField("password")
                .config {
                    $0.output.context.label.required = true
                    $0.output.context.type = .password
                }
        ]
    }
}
