//
//  FILE.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

@testable import App
import XCTVapor

final class AppTests: AppTestCase {
        
    func testHomePage() throws {
        let app = try createTestApp()
        defer { app.shutdown() }
        
        try app.testable(method: .inMemory).test(.GET, "") { res in
            XCTAssertEqual(res.status, .ok)
            
            let contentType = try XCTUnwrap(res.headers.contentType)
            XCTAssertEqual(contentType, .html)
            XCTAssertTrue(res.body.string.contains("Home"))
        }
    }
    
    func testAuth() throws {
        let app = try createTestApp()
        defer { app.shutdown() }
        
        let email = "root@localhost.com"
        let token = try authenticate(.init(email: email, password: "ChangeMe1"), app)
        XCTAssertEqual(token.user.email, email)
    }
}

