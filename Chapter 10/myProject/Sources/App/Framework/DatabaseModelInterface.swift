//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 31..
//

import Vapor
import Fluent

public protocol DatabaseModelInterface: Fluent.Model where Self.IDValue == UUID {
    
    associatedtype Module: ModuleInterface

    static var identifier: String { get }
}

public extension DatabaseModelInterface {

    static var schema: String { Module.identifier + "_" + identifier }
    
    static var identifier: String {
        String(describing: self).dropFirst(Module.identifier.count).dropLast(5).lowercased() + "s"
    }
}
