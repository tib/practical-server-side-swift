//
//  HTTP.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import Foundation

enum HTTP {

    enum Method: String {
        case get
        case post
        case put
        case patch
        case delete
    }

    enum Error: LocalizedError {
        case invalidResponse
        case statusCode(Int)
        case unknown(Swift.Error)
    }
}
