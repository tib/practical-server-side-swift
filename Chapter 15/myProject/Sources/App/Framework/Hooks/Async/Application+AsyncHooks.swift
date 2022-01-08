//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

import Vapor

extension Application {

    func invokeAsync<ReturnType>(_ name: String, args: HookArguments = [:]) async throws -> ReturnType? {
        let ctxArgs = args.merging(["app": self]) { (_, new) in new }
        return try await hooks.invokeAsync(name, args: ctxArgs)
    }

    func invokeAllAsync<ReturnType>(_ name: String, args: HookArguments = [:]) async throws -> [ReturnType] {
        let ctxArgs = args.merging(["app": self]) { (_, new) in new }
        return try await hooks.invokeAllAsync(name, args: ctxArgs)
    }
}
