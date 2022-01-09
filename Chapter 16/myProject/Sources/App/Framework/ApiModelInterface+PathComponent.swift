//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 09..
//

import Vapor

extension ApiModelInterface {

    static var pathIdComponent: PathComponent { .init(stringLiteral: ":" + pathIdKey) }
}

