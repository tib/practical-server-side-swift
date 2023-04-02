@resultBuilder
public enum FormComponentBuilder {
    
    public static func buildBlock(
        _ components: FormComponent...
    ) -> [FormComponent] {
        components
    }
}
