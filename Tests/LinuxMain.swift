import XCTest

import MatrixTests

var tests = [XCTestCaseEntry]()

tests += MatrixTests.allTests() // Adding library tests
tests += MatrixClientTests.allTests() // Adding client tests

// Running the tests
XCTMain(tests)
