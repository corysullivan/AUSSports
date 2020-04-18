import XCTest
@testable import AUS_API

final class AUS_APITests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AUS_API().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
