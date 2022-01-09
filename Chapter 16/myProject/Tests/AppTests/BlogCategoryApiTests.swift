//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

@testable import App
import XCTVapor

extension Blog.Category.Create: Content {}

final class BlogCategoryApiTests: AppTestCase {
    
    func testList() throws {
        let app = try createTestApp()
        let token = try authenticateRoot(app)
        defer { app.shutdown() }
        
        let headers = HTTPHeaders([("Authorization", "Bearer \(token.value)")])
        
        try app
        //.testable(method: .inMemory)
            .testable(method: .running(port: 8081))
            .test(.GET, "/api/blog/categories/", headers: headers) { res in
                XCTAssertEqual(res.status, .ok)
                let contentType = try XCTUnwrap(res.headers.contentType)
                XCTAssertEqual(contentType, .json)
                XCTAssertContent([Blog.Category.List].self, res) { content in
                    XCTAssertEqual(content.count, 4)
                }
            }
    }
    
    func testCreate() throws {
        let app = try createTestApp()
        let token = try authenticateRoot(app)
        defer { app.shutdown() }
        
        let headers = HTTPHeaders([("Authorization", "Bearer \(token.value)")])
        
        let newCategory = Blog.Category.Create(title: "Test category")
        
        try app.test(.POST, "/api/blog/categories/",
                     headers: headers,
                     content: newCategory) { res in
            XCTAssertEqual(res.status, .created)
            let contentType = try XCTUnwrap(res.headers.contentType)
            XCTAssertEqual(contentType, .json)
            XCTAssertContent(Blog.Category.Detail.self, res) { content in
                XCTAssertEqual(content.title, newCategory.title)
            }
        }
    }
    
    func testCreateListUpdate() throws {
        let app = try createTestApp()
        let token = try authenticateRoot(app)
        defer { app.shutdown() }
        
        let headers = HTTPHeaders([("Authorization", "Bearer \(token.value)")])
        
        let newCategory = Blog.Category.Create(title: "Test category")
        
        try app
            .test(.POST, "/api/blog/categories/",
                  headers: headers,
                  content: newCategory) { res in
                XCTAssertEqual(res.status, .created)
                let contentType = try XCTUnwrap(res.headers.contentType)
                XCTAssertEqual(contentType, .json)
                XCTAssertContent(Blog.Category.Detail.self, res) { content in
                    XCTAssertEqual(content.title, newCategory.title)
                }
            }
            .test(.GET, "/api/blog/categories/", headers: headers) { res in
                XCTAssertEqual(res.status, .ok)
                let contentType = try XCTUnwrap(res.headers.contentType)
                XCTAssertEqual(contentType, .json)
                XCTAssertContent([Blog.Category.List].self, res) { content in
                    XCTAssertEqual(content.count, 5)
                }
            }
    }
}

