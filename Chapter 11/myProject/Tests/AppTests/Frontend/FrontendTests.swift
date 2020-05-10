@testable import App
import XCTVapor

final class FrontendTests: XCTestCase {
    
    func testHomePage() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.testable(method: .inMemory).test(.GET, "") { res in
            XCTAssertEqual(res.status, .ok)
            let contentType = try XCTUnwrap(res.headers.contentType)
            XCTAssertEqual(contentType, .html)
            XCTAssertTrue(res.body.string.contains("myPage - Home"))
        }
    }
}
