//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

extension HookStorage {

    func registerAsync<ReturnType>(_ name: String, use block: @escaping AsyncHookFunctionSignature<ReturnType>) {
        let function = AsyncAnyHookFunction { args -> Any in
            try await block(args)
        }
        let pointer = HookFunctionPointer<AsyncHookFunction>(name: name, function: function, returnType: ReturnType.self)
        asyncPointers.append(pointer)
    }
    
    func invokeAsync<ReturnType>(_ name: String, args: HookArguments = [:]) async throws -> ReturnType? {
        try await asyncPointers.first { $0.name == name && $0.returnType == ReturnType.self }?.pointer.invokeAsync(args) as? ReturnType
    }

    func invokeAllAsync<ReturnType>(_ name: String, args: HookArguments = [:]) async throws -> [ReturnType] {
        let fns = asyncPointers.filter { $0.name == name && $0.returnType == ReturnType.self }
        var result: [ReturnType] = []
        for fn in fns {
            if let res = try await fn.pointer.invokeAsync(args) as? ReturnType {
                result.append(res)
            }
        }
        return result
    }
}
