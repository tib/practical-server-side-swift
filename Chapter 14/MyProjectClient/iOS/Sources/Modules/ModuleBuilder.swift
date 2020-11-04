//
//  ModuleBuilder.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import UIKit

final class ModuleBuilder: ModuleBuilderInterface {

    func root() -> UIViewController {
        RootModule().build()
    }

    func account() -> UIViewController {
        AccountModule().build()
    }
}
