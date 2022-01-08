//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

import Vapor

extension Application {

    private struct HookStorageKey: StorageKey {
        typealias Value = HookStorage
    }

    var hooks: HookStorage {
        get {
            if let existing = storage[HookStorageKey.self] {
                return existing
            }
            let new = HookStorage()
            storage[HookStorageKey.self] = new
            return new
        }
        set {
            storage[HookStorageKey.self] = newValue
        }
    }
}

extension Application {

    func invoke<ReturnType>(_ name: String, args: HookArguments = [:]) -> ReturnType? {
        let ctxArgs = args.merging(["app": self]) { (_, new) in new }
        return hooks.invoke(name, args: ctxArgs)
    }

    func invokeAll<ReturnType>(_ name: String, args: HookArguments = [:]) -> [ReturnType] {
        let ctxArgs = args.merging(["app": self]) { (_, new) in new }
        return hooks.invokeAll(name, args: ctxArgs)
    }
}
