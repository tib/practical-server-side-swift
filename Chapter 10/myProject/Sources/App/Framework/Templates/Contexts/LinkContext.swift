//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

import Vapor

public struct LinkContext {

    public let label: String
    public let path: String
    public let absolute: Bool
    public let isBlank: Bool
    public let dropLast: Int

    public init(label: String,
                path: String = "",
                absolute: Bool = false,
                isBlank: Bool = false,
                dropLast: Int = 0) {
        self.label = label
        self.path = path
        self.absolute = absolute
        self.isBlank = isBlank
        self.dropLast = dropLast
    }
    
    public func url(_ req: Request, _ infix: [PathComponent] = []) -> String {
        if absolute {
            return path
        }
        return "/" + (req.url.path.pathComponents.dropLast(dropLast) + (infix + path.pathComponents)).string
    }
}
