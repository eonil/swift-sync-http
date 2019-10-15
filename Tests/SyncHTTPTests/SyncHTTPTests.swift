import XCTest
@testable import SyncHTTP

final class SyncHTTPTests: XCTestCase {
    func test1() throws {
        let (status,body) = try SyncHTTP.call(
            method: "GET",
            address: "https://google.com",
            query: [
                URLQueryItem(name: "q", value: "xxx"),
                URLQueryItem(name: "z", value: "1111"),
            ])
        XCTAssertEqual(status, 200)
        XCTAssertTrue(body.count > 0)
    }
    func test2() throws {
        let reply = try SyncHTTP.get(address: "https://google.com")
        XCTAssertTrue(reply.count > 0)
    }
}
