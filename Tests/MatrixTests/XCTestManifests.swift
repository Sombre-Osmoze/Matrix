//
//  XCTestManifests.swift
//  MatrixTests
//
//  Created by Marcus Florentin on 12/05/2020.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
	return [
		testCase(MatrixTests.allTests),
		testCase(ResponsesTests.allTests),
		testCase(MatrixIDTests.allTests),
	]
}
#endif

