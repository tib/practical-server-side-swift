//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

public protocol ApiModuleInterface {
    static var pathKey: String { get }
}

public extension ApiModuleInterface {

    static var pathKey: String { String(describing: self).lowercased() }
}
