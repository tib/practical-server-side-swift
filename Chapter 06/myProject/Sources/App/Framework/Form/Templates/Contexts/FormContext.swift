//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 01..
//

public struct FormContext {
    public var action: FormAction
    public var error: String?
    public var fields: [TemplateRepresentable]
}
