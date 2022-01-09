//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

public struct AdminEditorPageContext {

    public let title: String
    public let form: FormContext
    public let navigation: [LinkContext]
    public let breadcrumbs: [LinkContext]
    public let actions: [LinkContext]

    public init(title: String,
                form: FormContext,
                navigation: [LinkContext] = [],
                breadcrumbs: [LinkContext] = [],
                actions: [LinkContext] = []) {
        self.title = title
        self.form = form
        self.navigation = navigation
        self.breadcrumbs = breadcrumbs
        self.actions = actions
    }
    
}

