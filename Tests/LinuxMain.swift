import XCTest

import MatrixTests
import MatrixClientTests

var tests = [XCTestCaseEntry]()

tests += MatrixTests.allTests() // Adding library tests
tests += MatrixClientTests.allTests() // Adding client tests

// Running the tests
XCTMain(tests)
