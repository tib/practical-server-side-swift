//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

struct AsyncAnyHookFunction: AsyncHookFunction {

    private let functionBlock: AsyncHookFunctionSignature<Any>

    init(_ functionBlock: @escaping AsyncHookFunctionSignature<Any>) {
        self.functionBlock = functionBlock
    }

    func invokeAsync(_ args: HookArguments) async throws -> Any {
        try await functionBlock(args)
    }
}
