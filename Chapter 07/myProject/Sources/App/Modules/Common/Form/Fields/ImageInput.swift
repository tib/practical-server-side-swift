import Foundation
import Vapor

public struct ImageInput: Codable {
    
    public var key: String
    
    public var file: File?
    public var currentKey: String?
    public var temporaryKey: String?
    public var temporaryName: String?
    public var remove: Bool

    public init(key: String, file: File? = nil, currentKey: String? = nil, temporaryKey: String? = nil, temporaryName: String? = nil, remove: Bool = false) {
        self.key = key
        self.file = file
        self.currentKey = currentKey
        self.temporaryKey = temporaryKey
        self.temporaryName = temporaryName
        self.remove = remove
    }

    public mutating func process(req: Request) {
        file = try? req.content.get(File.self, at: key)
        currentKey = try? req.content.get(String.self, at: key+"CurrentKey")
        temporaryKey = try? req.content.get(String.self, at: key+"TemporaryKey")
        temporaryName = try? req.content.get(String.self, at: key+"TemporaryName")
        remove = (try? req.content.get(Bool.self, at: key+"Remove")) ?? false
    }
}
