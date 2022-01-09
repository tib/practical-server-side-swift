//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

@testable import App
import XCTVapor

class AppTestCase: XCTestCase {
    
    struct UserLogin: Content {
        let email: String
        let password: String
    }
    
    func createTestApp() throws -> Application {
        let app = Application(.testing)
        
        try configure(app)
        app.databases.reinitialize()
        app.databases.use(.sqlite(.memory), as: .sqlite)
        app.databases.default(to: .sqlite)
        try app.autoMigrate().wait()
        return app
    }
    
    func authenticate(_ user: UserLogin, _ app: Application) throws -> User.Token.Detail {
        var token: User.Token.Detail?
        try app.test(.POST, "/api/sign-in/", beforeRequest: { req in
            try req.content.encode(user)
        }, afterResponse: { res in
            XCTAssertContent(User.Token.Detail.self, res) { content in
                token = content
            }
        })
        guard let result = token else {
            XCTFail("Login failed")
            throw Abort(.unauthorized)
        }
        return result
    }
    
    func authenticateRoot(_ app: Application) throws -> User.Token.Detail {
        try authenticate(.init(email: "root@localhost.com", password: "ChangeMe1"), app)
    }
}

