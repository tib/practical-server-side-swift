//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 01..
//

@resultBuilder
public enum FormComponentBuilder {
    
    public static func buildBlock(_ components: FormComponent...) -> [FormComponent] {
        components
    }
}

