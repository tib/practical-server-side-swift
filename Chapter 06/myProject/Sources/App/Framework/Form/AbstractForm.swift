//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 01..
//

import Foundation

open class AbstractForm {

    open var action: FormAction
    open var error: String?
    open var fields: [Any]
    
    public init(action: FormAction = .init(),
                error: String? = nil,
                fields: [Any] = []) {
        self.action = action
        self.error = error
        self.fields = fields
    }
}
