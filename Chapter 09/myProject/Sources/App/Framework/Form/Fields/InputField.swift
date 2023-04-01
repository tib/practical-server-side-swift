public final class InputField: AbstractFormField<
    String,
    InputFieldTemplate
> {

    public convenience init(_ key: String) {
        self.init(
            key: key,
            input: "",
            output: .init(
                .init(
                    key: key
                )
            )
        )
    }
}
