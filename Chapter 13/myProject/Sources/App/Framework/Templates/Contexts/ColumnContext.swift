//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

public struct ColumnContext {
    
    public let key: String
    public let label: String

    public init(_ key: String, label: String? = nil) {
        self.key = key
        self.label = label ?? key.capitalized
    }
}
