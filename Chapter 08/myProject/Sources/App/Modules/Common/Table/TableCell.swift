import Foundation

public struct TableCell: Encodable {
    
    public enum `Type`: String, Encodable {
        case text
        case image
    }
    
    public let type: Type
    public let value: String?

    public init(type: TableCell.`Type` = .text, _ value: String? = nil) {
        self.type = type
        self.value = value
    }
}
