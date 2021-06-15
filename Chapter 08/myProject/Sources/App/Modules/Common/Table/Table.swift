import Foundation

public struct Table: Encodable {

    public let id: String?
    public let columns: [TableColumn]
    public var rows: [TableRow]
    public var action: TableRowAction?

    public init(id: String? = nil, columns: [TableColumn], rows: [TableRow] = [], action: TableRowAction? = nil) {
        self.id = id
        self.columns = columns
        self.rows = rows
        self.action = action
    }
}
