//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 04..
//

public struct AdminListPageContext {

    public let title: String
    public let table: TableContext
    public let navigation: [LinkContext]
    public let breadcrumbs: [LinkContext]
    
    public init(title: String,
                table: TableContext,
                navigation: [LinkContext] = [],
                breadcrumbs: [LinkContext] = []) {
        self.title = title
        self.table = table
        self.navigation = navigation
        self.breadcrumbs = breadcrumbs
    }
}
