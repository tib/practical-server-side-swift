//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 01..
//

import Vapor

open class AbstractFormField<Input: Decodable, Output: TemplateRepresentable>: FormComponent {
    
    public var key: String
    public var input: Input
    public var output: Output
    public var error: String?

    public init(key: String, input: Input, output: Output, error: String? = nil) {
        self.key = key
        self.input = input
        self.output = output
        self.error = error
    }

    open func config(_ block: (AbstractFormField<Input, Output>) -> Void) -> Self {
        block(self)
        return self
    }
    
    // MARK: - FormComponent
    
    open func load(req: Request) async throws {
        
    }
    
    open func process(req: Request) async throws {
        if let value = try? req.content.get(Input.self, at: key) {
            input = value
        }
    }
    
    open func validate(req: Request) async throws -> Bool {
        true
    }
    
    open func write(req: Request) async throws {
        
    }
    
    open func save(req: Request) async throws {
        
    }
    
    open func read(req: Request) async throws {
        
    }
    
    open func render(req: Request) -> TemplateRepresentable {
        output
    }
}
