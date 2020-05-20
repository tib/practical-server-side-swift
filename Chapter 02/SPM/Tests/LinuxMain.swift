import XCTest

import myProjectTests

var tests = [XCTestCaseEntry]()
tests += myProjectTests.allTests()
XCTMain(tests)
