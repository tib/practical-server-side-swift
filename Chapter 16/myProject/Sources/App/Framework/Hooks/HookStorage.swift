//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

final class HookStorage {

    var pointers: [HookFunctionPointer<HookFunction>]
    var asyncPointers: [HookFunctionPointer<AsyncHookFunction>]

    init() {
        self.pointers = []
        self.asyncPointers = []
    }    
}

