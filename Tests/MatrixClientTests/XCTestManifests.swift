//
//  XCTestManifests.swift
//  MatrixClientTests
//
//  Created by Marcus Florentin on 12/05/2020.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
		testCase(EndpointsTests.allTests),
        testCase(MatrixClientTests.allTests),
		testCase(ResponsesTests.allTests),
    ]
}
#endif
