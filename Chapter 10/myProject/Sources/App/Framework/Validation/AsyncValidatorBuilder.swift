//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

@resultBuilder
public enum AsyncValidatorBuilder {
    
    public static func buildBlock(_ components: AsyncValidator...) -> [AsyncValidator] {
        components
    }
}
