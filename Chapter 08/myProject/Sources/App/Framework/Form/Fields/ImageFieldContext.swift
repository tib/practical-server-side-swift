//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

public struct ImageFieldContext {

    public let key: String
    public var label: LabelContext
    public var data: FormImageData
    public var previewUrl: String?
    public var accept: String?
    public var error: String?
    
    public init(key: String,
                label: LabelContext? = nil,
                data: FormImageData = .init(),
                previewUrl: String? = nil,
                accept: String? = nil,
                error: String? = nil) {
        self.key = key
        self.label = label ?? .init(key: key)
        self.data = data
        self.previewUrl = previewUrl
        self.accept = accept
        self.error = error
    }
}
