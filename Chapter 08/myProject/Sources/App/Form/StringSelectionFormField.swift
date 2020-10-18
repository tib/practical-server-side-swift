import Leaf

struct StringSelectionFormField: LeafDataRepresentable {
    
    var value: String = ""
    var error: String? = nil
    var options: [FormFieldStringOption] = []
    
    var leafData: LeafData {
        .dictionary([
            "value": .string(value),
            "error": .string(error),
            "options": .array(options.map(\.leafData)),
        ])
    }
}
