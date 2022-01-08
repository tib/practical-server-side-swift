//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

protocol AsyncHookFunction {
    func invokeAsync(_: HookArguments) async throws -> Any
}

typealias AsyncHookFunctionSignature<T> = (HookArguments) async throws -> T
