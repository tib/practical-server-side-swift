//
//  ServiceBuilder.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import Foundation

final class ServiceBuilder: ServiceBuilderInterface {

    lazy var api: ApiServiceInterface = {
        MyProjectApiService(baseUrl: "http://192.168.0.129:3000/api")
    }()
}
