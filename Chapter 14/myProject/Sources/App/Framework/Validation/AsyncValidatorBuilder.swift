@resultBuilder
public enum AsyncValidatorBuilder {
    
    public static func buildBlock(
        _ components: AsyncValidator...
    ) -> [AsyncValidator] {
        components
    }
}
