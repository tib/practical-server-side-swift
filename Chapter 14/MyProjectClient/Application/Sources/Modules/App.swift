//
//  App.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import Foundation

final class App {

    let services = ServiceBuilder()

    // MARK: - singleton

    static let shared = App()

    private init() {
        // do nothing...
    }

    // MARK: - api

    func setup() {
        self.services.setup()
    }
}
