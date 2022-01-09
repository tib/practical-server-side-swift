//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Foundation

public struct Name {
   
    let singular: String
    let plural: String
    
    internal init(singular: String, plural: String? = nil) {
        self.singular = singular
        self.plural = plural ?? singular + "s"
    }
}
