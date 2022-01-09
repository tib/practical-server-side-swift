//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

struct AnyHookFunction: HookFunction {

    private let functionBlock: HookFunctionSignature<Any>

    init(_ functionBlock: @escaping HookFunctionSignature<Any>) {
        self.functionBlock = functionBlock
    }

    func invoke(_ args: HookArguments) -> Any {
        functionBlock(args)
    }
}
