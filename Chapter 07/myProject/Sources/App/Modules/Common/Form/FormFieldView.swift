protocol FormFieldView: Encodable {
    var type: FormFieldType { get }

    var key: String { get }
    var required: Bool { get }
    var error: String? { get set }
}
