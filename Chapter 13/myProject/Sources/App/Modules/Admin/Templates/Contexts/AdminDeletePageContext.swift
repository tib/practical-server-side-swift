//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

public struct AdminDeletePageContext {

    public let title: String
    public let name: String
    public let type: String
    public let form: FormContext
    public let navigation: [LinkContext]
    public let breadcrumbs: [LinkContext]
    
    public init(title: String,
                name: String,
                type: String,
                form: FormContext,
                navigation: [LinkContext] = [],
                breadcrumbs: [LinkContext] = []) {
        self.title = title
        self.name = name
        self.type = type
        self.form = form
        self.navigation = navigation
        self.breadcrumbs = breadcrumbs
    }

}

