public struct LabelContext {
    
    public var key: String
    public var title: String?
    public var required: Bool
    public var more: String?
    
    public init(
        key: String,
        title: String? = nil,
        required: Bool = false,
        more: String? = nil
    ) {
        self.key = key
        self.title = title
        self.required = required
        self.more = more
    }
}
