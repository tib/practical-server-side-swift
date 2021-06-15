import Foundation

public struct TableRow: Encodable {

    public let id: String
    public let cells: [TableCell]

    public init(id: String, cells: [TableCell]) {
        self.id = id
        self.cells = cells
    }
}
