//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 01..
//

import Vapor

open class AbstractFormField<Input: Decodable, Output: TemplateRepresentable> {
    
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
}
