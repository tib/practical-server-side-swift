import XCTest
@testable import MyProjectApi

final class MyProjectApiTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MyProjectApi().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
