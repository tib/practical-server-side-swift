import Foundation

public struct Noun {

    private var irregular: String?

    public let singular: String
    public var plural: String { irregular ?? singular + "s" }

    public init(singular: String, plural irregular: String? = nil) {
        self.singular = singular
        self.irregular = irregular
    }
}

extension Noun: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.init(singular: value)
    }
}
