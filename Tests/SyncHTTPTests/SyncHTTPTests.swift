import XCTest
@testable import SyncHTTP

final class SyncHTTPTests: XCTestCase {
    func test1() throws {
        let (status,body) = try SyncHTTP.call(method: "GET", address: "https://google.com")
        XCTAssertEqual(status, 200)
        XCTAssertTrue(body.count > 0)
    }
    func test2() throws {
        let reply = try SyncHTTP.get(address: "https://google.com")
        XCTAssertTrue(reply.count > 0)
    }
}
