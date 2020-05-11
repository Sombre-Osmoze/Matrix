//
//  EndpointsTests.swift
//  MatrixClientTests
//
//  Created by Marcus Florentin on 11/05/2020.
//

import XCTest
@testable import MatrixClient

final class EndpointsTests: XCTestCase {

	private let endpoints : Endpoints = .init(protection: protectionSpace)

	// MARK: - Endpoint

	func testVersionEndpoint() {
		let url = Endpoints.version(protection: protectionSpace)

		XCTAssertEqual(url?.path, "/_matrix/client/versions",
					   "Matrix client version path is invalid")
	}

	// MARK: - Login
	func testLogin() {

	}


	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct
		// results.
		//        XCTAssertEqual(Matrix().text, "Hello, World!")
	}

	static var allTests = [
		("testExample", testExample),
	]
}
