@testable import AppApi
import XCTest

final class AppApiTests: XCTestCase {
    
    enum HTTPError: Error {
        case invalidResponse
        case invalidStatusCode(Int)
    }
    
    let baseUrl = URL(string: "http://localhost:8080/api/")!
    
    private func authenticate(
        _ login: User.Account.Login
    ) async throws -> User.Token.Detail {
        var req = URLRequest(url: baseUrl.appendingPathComponent("sign-in/"))
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONEncoder().encode(login)

        let (data, response) = try await URLSession.shared.data(for: req)
        guard let response = response as? HTTPURLResponse else {
            throw HTTPError.invalidResponse
        }
        guard 200...299 ~= response.statusCode else {
            throw HTTPError.invalidStatusCode(response.statusCode)
        }
        return try JSONDecoder().decode(User.Token.Detail.self, from: data)
    }
    
    private func authenticateRoot() async throws -> User.Token.Detail {
        try await authenticate(
            .init(
                email: "root@localhost.com",
                password: "ChangeMe1"
            )
        )
    }
    
    func testAuthorization() async throws {
        let login = User.Account.Login(
            email: "root@localhost.com",
            password: "ChangeMe1"
        )
        let token = try await authenticate(login)
        XCTAssertEqual(token.value.count, 64)
        XCTAssertEqual(token.user.email, login.email)
    }
    
    func testBlogCategories() async throws {
        let token = try await authenticateRoot()
        
        let path = "\(Blog.pathKey)/\(Blog.Category.pathKey)/"
        var req = URLRequest(url: baseUrl.appendingPathComponent(path))
        req.addValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: req)
        guard let response = response as? HTTPURLResponse else {
            throw HTTPError.invalidResponse
        }
        guard 200...299 ~= response.statusCode else {
            throw HTTPError.invalidStatusCode(response.statusCode)
        }
        let decoder = JSONDecoder()
        let categories = try decoder.decode([Blog.Category.List].self, from: data)
        XCTAssertFalse(categories.isEmpty)
    }
}
