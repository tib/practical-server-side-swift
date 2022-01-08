//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 08..
//

@testable import App
import XCTVapor
import Spec

extension Blog.Post.Create: Content {}
extension Blog.Post.Update: Content {}

final class BlogPostApiTests: AppTestCase {

    func testList() throws {
        let app = try createTestApp()
        let token = try authenticateRoot(app)
        defer { app.shutdown() }
                
        try app
            .describe("Blog posts list API should be fine")
            .get("/api/blog/posts/")
            .bearerToken(token.value)
            .expect(.ok)
            .expect(.json)
            .expect([Blog.Post.List].self) { content in
                XCTAssertEqual(content.count, 9)
            }
            .test()
    }
    
    func testCreate() async throws {
        let app = try createTestApp()
        let token = try authenticateRoot(app)
        defer { app.shutdown() }
        
        let category = try await BlogCategoryModel.query(on: app.db).first()
        guard let category = category else {
            XCTFail("Missing default category")
            throw Abort(.notFound)
        }

        let newPost = Blog.Post.Create(title: "Dummy post",
                                       slug: "dummy-slug",
                                       image: "/dummy/image.jpg",
                                       excerpt: "Lorem ipsum",
                                       date: Date(),
                                       content: "Lorem ipsum",
                                       categoryId: category.id!)

        try app
            .describe("Create post should be fine")
            .post("/api/blog/posts/")
            .body(newPost)
            .bearerToken(token.value)
            .expect(.created)
            .expect(.json)
            .expect(Blog.Post.Detail.self) { content in
                XCTAssertEqual(content.title, newPost.title)
            }
            .test()
    }
    
    func testUpdate() async throws {
        let app = try self.createTestApp()
        let token = try authenticateRoot(app)
        defer { app.shutdown() }

        guard let post = try await BlogPostModel.query(on: app.db).with(\.$category).first() else {
            XCTFail("Missing blog post")
            throw Abort(.notFound)
        }

        let suffix = " updated"

        let newPost = Blog.Post.Update(title: post.title + suffix,
                                       slug: post.slug + suffix,
                                       image: post.imageKey + suffix,
                                       excerpt: post.excerpt + suffix,
                                       date: post.date,
                                       content: post.content + suffix,
                                       categoryId: post.category.id!)
        
        try app
            .describe("Update post should be fine")
            .put("/api/blog/posts/\(post.id!.uuidString)/")
            .body(newPost)
            .bearerToken(token.value)
            .expect(.ok)
            .expect(.json)
            .expect(Blog.Post.Detail.self) { content in
                XCTAssertEqual(content.id, post.id)
                XCTAssertEqual(content.title, newPost.title)
                XCTAssertEqual(content.slug, newPost.slug)
                XCTAssertEqual(content.image, newPost.image)
                XCTAssertEqual(content.excerpt, newPost.excerpt)
                XCTAssertEqual(content.content, newPost.content)
            }
            .test()
    }
}

