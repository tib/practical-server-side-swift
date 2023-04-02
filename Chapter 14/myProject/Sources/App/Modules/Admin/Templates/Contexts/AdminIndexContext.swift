public struct AdminIndexContext {
    public let title: String
    public let breadcrumbs: [LinkContext]
    
    public init(
        title: String,
        breadcrumbs: [LinkContext] = []
    ) {
        self.title = title
        self.breadcrumbs = breadcrumbs
    }
}
