public struct TableContext {
    
    public let columns: [ColumnContext]
    public let rows: [RowContext]
    public let actions: [LinkContext]
    
    public init(
        columns: [ColumnContext],
        rows: [RowContext],
        actions: [LinkContext] = []
    ) {
        self.columns = columns
        self.rows = rows
        self.actions = actions
    }
}
