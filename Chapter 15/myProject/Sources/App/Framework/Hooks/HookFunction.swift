//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

typealias HookArguments = [String: Any]

protocol HookFunction {
    func invoke(_: HookArguments) -> Any
}

typealias HookFunctionSignature<T> = (HookArguments) -> T
