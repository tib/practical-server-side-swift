//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

import Vapor

extension Request {

    func invoke<ReturnType>(_ name: String, args: HookArguments = [:]) -> ReturnType? {
        let ctxArgs = args.merging(["req": self]) { (_, new) in new }
        return application.invoke(name, args: ctxArgs)
    }

    func invokeAll<ReturnType>(_ name: String, args: HookArguments = [:]) -> [ReturnType] {
        let ctxArgs = args.merging(["req": self]) { (_, new) in new }
        return application.invokeAll(name, args: ctxArgs)
    }
}
