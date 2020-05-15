//
//  ServiceInteractor.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import Foundation

class ServiceInteractor {

    let services: ServiceBuilderInterface

    init(services: ServiceBuilderInterface = App.shared.services) {
        self.services = services
    }
}
