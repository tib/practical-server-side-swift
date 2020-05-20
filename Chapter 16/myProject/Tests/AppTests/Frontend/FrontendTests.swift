@testable import App
import XCTVapor

final class FrontendTests: AppTestCase {

    func testHomePage() throws {
        let app = try self.createTestApp()
        defer { app.shutdown() }

        try app.testable(method: .inMemory).test(.GET, "") { res in
            XCTAssertEqual(res.status, .ok)
            let contentType = try XCTUnwrap(res.headers.contentType)
            XCTAssertEqual(contentType, .html)
            XCTAssertTrue(res.body.string.contains("myPage - Home"))
        }
    }
}
