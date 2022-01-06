//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

public struct CellContext {

    public enum `Type`: String {
        case text
        case image
    }

    public let value: String
    public let link: LinkContext?
    public let type: `Type`

    public init(_ value: String, link: LinkContext? = nil, type: `Type` = .text) {
        self.type = type
        self.value = value
        self.link = link
    }
}
