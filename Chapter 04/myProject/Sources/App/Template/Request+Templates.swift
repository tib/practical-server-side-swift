//
//  Request+Template.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor

public extension Request {
    var templates: TemplateRenderer { .init(self) }
}
