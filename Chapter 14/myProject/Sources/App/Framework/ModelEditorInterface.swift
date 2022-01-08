//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

import Vapor

public protocol ModelEditorInterface: FormComponent {
    associatedtype Model: DatabaseModelInterface
    
    var model: Model { get }
    var form: AbstractForm { get }
    
    init(model: Model, form: AbstractForm)
        
    @FormComponentBuilder
    var formFields: [FormComponent] { get }
}

public extension ModelEditorInterface {

    func load(req: Request) async throws {
        try await form.load(req: req)
    }
    
    func process(req: Request) async throws {
        try await form.process(req: req)
    }

    func validate(req: Request) async throws -> Bool {
        try await form.validate(req: req)
    }
    
    func write(req: Request) async throws {
        try await form.write(req: req)
    }
    
    func save(req: Request) async throws {
        try await form.save(req: req)
    }
    
    func read(req: Request) async throws {
        try await form.read(req: req)
    }

    func render(req: Request) -> TemplateRepresentable {
        form.render(req: req)
    }
}
