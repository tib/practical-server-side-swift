protocol HookFunction {
    func invoke(_: HookArguments) -> Any
}

typealias HookFunctionSignature<T> = (HookArguments) -> T
