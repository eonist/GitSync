import XCTest
@testable import GitSyncMac

class GitSyncMacTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(GitSyncMac().text, "Hello, World!")
    }


    static var allTests : [(String, (GitSyncMacTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
