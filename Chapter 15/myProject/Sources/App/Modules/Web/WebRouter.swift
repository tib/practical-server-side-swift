//
//  WebRouter.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor

struct WebRouter: RouteCollection {
    
    let controller = WebFrontendController()

    func boot(routes: RoutesBuilder) throws {
        routes.get(use: controller.homeView)
    }
    
    func setUpRoutesHooks(app: Application) throws {
        app.routes.get(.anything, use: controller.anyResponse)
    }
}
