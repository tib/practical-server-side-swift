//
//  App.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

@_exported import VIPER
import Foundation

final class App {

    let services: ServiceBuilderInterface
    let modules: ModuleBuilderInterface

    // MARK: - singleton

    static let shared = App()

    private init() {
        // do nothing...
        
        self.services = ServiceBuilder()
        self.modules = ModuleBuilder()
    }

    // MARK: - api

    func setup() {
        self.services.setup()
    }
    
}
