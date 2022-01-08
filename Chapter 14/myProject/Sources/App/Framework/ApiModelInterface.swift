//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

protocol ApiModelInterface {
    associatedtype Module: ApiModuleInterface
    
    static var pathKey: String { get }
    static var pathIdKey: String { get }
}

extension ApiModelInterface {
    static var pathKey: String { String(describing: self).lowercased() + "s" }
    static var pathIdKey: String { String(describing: self).lowercased() + "Id" }
    
    static var pathIdComponent: PathComponent { .init(stringLiteral: ":" + pathIdKey) }
}

