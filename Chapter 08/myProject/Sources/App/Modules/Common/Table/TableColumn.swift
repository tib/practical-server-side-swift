import Foundation

public struct TableColumn: Encodable {

    public let id: String
    public let label: String?
    
    public init(id: String, label: String? = nil) {
        self.id = id
        self.label = label ?? id.capitalized
    }
}

extension TableColumn: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.init(id: value, label: nil)
    }
}
