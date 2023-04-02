extension HookStorage {

    func register<ReturnType>(
        _ name: String,
        use block: @escaping HookFunctionSignature<ReturnType>
    ) {
        let function = AnyHookFunction { args -> Any in
            block(args)
        }
        let pointer = HookFunctionPointer<HookFunction>(
            name: name,
            function: function,
            returnType: ReturnType.self
        )
        pointers.append(pointer)
    }

    func invoke<ReturnType>(
        _ name: String,
        args: HookArguments = [:]
    ) -> ReturnType? {
        pointers.first {
            $0.name == name && $0.returnType == ReturnType.self
        }?.pointer.invoke(args) as? ReturnType
    }
 
    func invokeAll<ReturnType>(
        _ name: String, args: HookArguments = [:]
    ) -> [ReturnType] {
        pointers.filter {
            $0.name == name && $0.returnType == ReturnType.self
        }
        .compactMap {
            $0.pointer.invoke(args) as? ReturnType
        }
    }
}
