//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

public struct AdminDetailPageContext {
    
    public let title: String
    public let fields: [DetailContext]
    public let navigation: [LinkContext]
    public let breadcrumbs: [LinkContext]
    public let actions: [LinkContext]

    public init(title: String,
                fields: [DetailContext],
                navigation: [LinkContext] = [],
                breadcrumbs: [LinkContext] = [],
                actions: [LinkContext] = []) {
        self.title = title
        self.fields = fields
        self.navigation = navigation
        self.breadcrumbs = breadcrumbs
        self.actions = actions
    }
}

