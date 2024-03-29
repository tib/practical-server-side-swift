protocol AsyncHookFunction {
    func invokeAsync(_: HookArguments) async throws -> Any
}

typealias AsyncHookFunctionSignature<T> = (HookArguments) async throws -> T
