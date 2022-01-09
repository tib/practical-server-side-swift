//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

public protocol ApiModelInterface {
    associatedtype Module: ApiModuleInterface
    
    static var pathKey: String { get }
    static var pathIdKey: String { get }
}

public extension ApiModelInterface {
    static var pathKey: String { String(describing: self).lowercased() + "s" }
    static var pathIdKey: String { String(describing: self).lowercased() + "Id" }
}

