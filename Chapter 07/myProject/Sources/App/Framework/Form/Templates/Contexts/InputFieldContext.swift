import SwiftHtml

public struct InputFieldContext {
    
    public let key: String
    public var label: LabelContext
    public var type: SwiftHtml.Input.`Type`
    public var placeholder: String?
    public var value: String?
    public var error: String?
    
    public init(
        key: String,
        label: LabelContext? = nil,
        type: Input.`Type` = .text,
        placeholder: String? = nil,
        value: String? = nil,
        error: String? = nil
    ) {
        self.key = key
        self.label = label ?? .init(key: key)
        self.type = type
        self.placeholder = placeholder
        self.value = value
        self.error = error
    }
}
