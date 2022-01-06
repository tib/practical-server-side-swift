//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Foundation

protocol ApiModelInterface {
    static var pathIdKey: String { get }
}

extension ApiModelInterface {
    static var pathIdKey: String { String(describing: self).lowercased() + "Id" }
}

