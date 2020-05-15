//
//  ServiceBuilderInterface.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import Foundation

protocol ServiceBuilderInterface {

    var api: ApiServiceInterface { get }

    func setup()
}

extension ServiceBuilderInterface {

    func setup() {
        self.api.setup()
    }
}
