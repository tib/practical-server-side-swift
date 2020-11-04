//
//  ModuleRouter.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 20..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import Foundation

class ModuleRouter {

    let modules: ModuleBuilderInterface

    init(modules: ModuleBuilderInterface = App.shared.modules) {
        self.modules = modules
    }
}
