import XCTest
@testable import WeaselRoll

final class WeaselRollTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WeaselRoll().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
