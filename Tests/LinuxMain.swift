import XCTest

import SyncHTTPTests

var tests = [XCTestCaseEntry]()
tests += SyncHTTPTests.allTests()
XCTMain(tests)
