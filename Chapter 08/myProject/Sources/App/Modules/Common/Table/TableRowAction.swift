import Foundation

public struct TableRowAction: Encodable {
    
    public let label: String
    public let icon: String
    public let url: String
    
    public init(label: String, icon: String, url: String) {
        self.label = label
        self.icon = icon
        self.url = url
    }
}
