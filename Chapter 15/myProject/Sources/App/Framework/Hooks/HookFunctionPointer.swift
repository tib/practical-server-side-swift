//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

final class HookFunctionPointer<Pointer> {

    var name: String
    var pointer: Pointer
    var returnType: Any.Type
    
    init(name: String, function: Pointer, returnType: Any.Type) {
        self.name = name
        self.pointer = function
        self.returnType = returnType
    }
}
