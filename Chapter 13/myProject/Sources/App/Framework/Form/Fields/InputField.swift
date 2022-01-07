//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 01..
//

import Vapor

public final class InputField: AbstractFormField<String, InputFieldTemplate> {

    public convenience init(_ key: String) {
        self.init(key: key, input: "", output: .init(.init(key: key)))
    }

    public override func process(req: Request) async throws {
        try await super.process(req: req)
        output.context.value = input
    }

    public override func render(req: Request) -> TemplateRepresentable {
        output.context.error = error
        return super.render(req: req)
    }
}
