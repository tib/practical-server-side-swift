//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

struct AnyHookFunction: HookFunction {

    private let functionBlock: HookFunctionSignature<Any>

    /// anonymous hooks can be initialized using a function block
    init(_ functionBlock: @escaping HookFunctionSignature<Any>) {
        self.functionBlock = functionBlock
    }

    /// since they are hook functions they can be invoked with a given argument
    func invoke(_ args: HookArguments) -> Any {
        functionBlock(args)
    }
}
