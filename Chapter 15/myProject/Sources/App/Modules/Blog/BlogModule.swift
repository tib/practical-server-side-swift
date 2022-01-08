//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 31..
//

import Vapor

struct BlogModule: ModuleInterface {

    let router = BlogRouter()

    func boot(_ app: Application) throws {
        app.migrations.add(BlogMigrations.v1())
        app.migrations.add(BlogMigrations.seed())
        
        app.hooks.register("admin-widget", use: adminWidgetHook)
        app.hooks.register("admin-routes", use: router.adminRoutesHook)
        app.hooks.register("api-routes", use: router.apiRoutesHook)
        
        app.hooks.registerAsync("response", use: router.responseHook)

        try router.boot(routes: app.routes)
    }
    
    func adminWidgetHook(_ args: HookArguments) -> TemplateRepresentable {
        BlogAdminWidgetTemplate()
    }
}

