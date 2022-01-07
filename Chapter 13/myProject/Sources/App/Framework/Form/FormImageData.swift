//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

public struct FormImageData: Codable {
        
    public struct TemporaryFile: Codable {
        public let key: String
        public let name: String
        
        public init(key: String, name: String) {
            self.key = key
            self.name = name
        }
    }

    public var originalKey: String?
    public var temporaryFile: TemporaryFile?
    public var shouldRemove: Bool

    public init(originalKey: String? = nil,
                temporaryFile: TemporaryFile? = nil,
                shouldRemove: Bool = false) {
        self.originalKey = originalKey
        self.temporaryFile = temporaryFile
        self.shouldRemove = shouldRemove
    }
}
