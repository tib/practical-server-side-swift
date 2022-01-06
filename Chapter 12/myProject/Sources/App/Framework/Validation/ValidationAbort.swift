//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor

public struct ValidationAbort: AbortError {

    public var abort: Abort
    public var message: String?
    public var details: [ValidationErrorDetail]

    public var reason: String { abort.reason }
    public var status: HTTPStatus { abort.status }
    
    public init(abort: Abort, message: String? = nil, details: [ValidationErrorDetail]) {
        self.abort = abort
        self.message = message
        self.details = details
    }
}
