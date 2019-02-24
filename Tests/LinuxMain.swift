import XCTest

import animeTests

var tests = [XCTestCaseEntry]()
tests += animeTests.allTests()
XCTMain(tests)