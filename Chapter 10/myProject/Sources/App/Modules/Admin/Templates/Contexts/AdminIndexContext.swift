//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

public struct AdminIndexContext {
    public let title: String
    public var breadcrumbs: [LinkContext]
    
    public init(title: String, breadcrumbs: [LinkContext] = []) {
        self.title = title
        self.breadcrumbs = breadcrumbs
    }
}
