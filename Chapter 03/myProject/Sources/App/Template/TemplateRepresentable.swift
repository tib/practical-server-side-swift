//
//  TemplateRepresentable.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import SwiftSgml

public protocol TemplateRepresentable {
    
    @TagBuilder
    func render(_ req: Request) -> Tag
}
