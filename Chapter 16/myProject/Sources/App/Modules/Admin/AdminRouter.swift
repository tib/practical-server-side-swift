//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor

struct AdminRouter: RouteCollection {
    
    let controller = AdminFrontendController()

    func boot(routes: RoutesBuilder) throws {}

    func setUpRoutesHooks(app: Application) throws {
        let adminRoutes = app.routes
            .grouped(AuthenticatedUser.redirectMiddleware(path: "/sign-in/"))
            .grouped("admin")

        let _: [Void] = app.invokeAll("admin-routes", args: ["routes": adminRoutes])
    }
    
    func adminRoutesHook(_ args: HookArguments) -> Void {
        let routes = args["routes"] as! RoutesBuilder

        routes.get(use: controller.dashboardView)
    }
}
