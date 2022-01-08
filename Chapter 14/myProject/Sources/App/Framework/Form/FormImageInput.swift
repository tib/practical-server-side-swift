//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor

public struct FormImageInput: Codable {
    
    public var key: String
    public var file: File?
    public var data: FormImageData

    public init(key: String, file: File? = nil, data: FormImageData? = nil) {
        self.key = key
        self.file = file
        self.data = data ?? .init()
    }
}
