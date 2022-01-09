//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor

public extension ByteBuffer {
    var data: Data? { getData(at: 0, length: readableBytes) }
}
