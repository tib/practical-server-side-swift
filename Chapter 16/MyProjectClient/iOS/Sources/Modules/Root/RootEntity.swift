//
//  RootEntity.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 16..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import Foundation

struct RootEntity {

    struct Item {
        let id: UUID
        let title: String
        let imageUrl: URL
        let url: URL
    }

    let items: [Item]
}
