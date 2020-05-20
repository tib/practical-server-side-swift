@testable import App
import XCTVapor
import Fluent
import FluentSQLiteDriver
import LiquidLocalDriver

extension XCTApplicationTester {
    @discardableResult public func test<T>(
        _ method: HTTPMethod,
        _ path: String,
        headers: HTTPHeaders = [:],
        content: T,
        afterResponse: (XCTHTTPResponse) throws -> () = { _ in }
    ) throws -> XCTApplicationTester where T: Content {
        try test(method, path, headers: headers, beforeRequest: { req in
            try req.content.encode(content)
        }, afterResponse: afterResponse)
    }
}

open class AppTestCase: XCTestCase {
    
    func createTestApp() throws -> Application {
        let app = Application(.testing)
        try configure(app)
        app.databases.use(.sqlite(.memory), as: .sqlite)
        app.databases.default(to: .sqlite)
        app.fileStorages.use(.local(publicUrl: "http://localhost:8080",
                                    publicPath: app.directory.publicDirectory,
                                    workDirectory: "assets"), as: .local)
        app.fileStorages.default(to: .local)
        
        try app.autoMigrate().wait()
        return app
    }

    func getApiToken(_ app: Application) throws -> String {
        struct UserLoginRequest: Content {
            let email: String
            let password: String
        }
        struct UserTokenResponse: Content {
            let id: String
            let value: String
        }

        let userBody = UserLoginRequest(email: "mail.tib@gmail.com",
                                    password: "ChangeMe1")
        
        var token: String?

        try app.test(.POST, "/api/user/login", beforeRequest: { req in
            try req.content.encode(userBody)
        }, afterResponse: { res in
            XCTAssertContent(UserTokenResponse.self, res) { content in
                token = content.value
            }
        })
        guard let t = token else {
            XCTFail("Login failed")
            throw Abort(.unauthorized)
        }
        return t
    }
}
