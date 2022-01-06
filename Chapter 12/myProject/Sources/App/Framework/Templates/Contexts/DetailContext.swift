//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

public struct DetailContext {

    public enum `Type`: String {
        case text
        case image
    }

    public let key: String
    public let label: String
    public let value: String
    public let type: `Type`
    
    public init(_ key: String,
                _ value: String,
                label: String? = nil,
                type: `Type` = .text) {
        self.key = key
        self.label = label ?? key.capitalized
        self.value = value
        self.type = type
    }
}
