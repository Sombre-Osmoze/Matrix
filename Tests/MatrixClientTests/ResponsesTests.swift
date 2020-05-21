//
//  ResponsesTests.swift
//  MatrixClientTests
//
//  Created by Marcus Florentin on 17/05/2020.
//


import XCTest
@testable import MatrixClient

final class ResponsesTests: XCTestCase {

	let responsesFolder : URL = {
		var url = resourceFolder
		url.appendPathComponent("Responses")
		return url
	}()

	// MARK: - Login

	func testLoginResponseDecoding() throws {

		let data = try file(named: "login", in: responsesFolder)


		XCTAssertNoThrow(try decoder.decode(LoginResponse.self, from: data))

	}


	static var allTests = [
		("Test login response decoding", testLoginResponseDecoding),
	]
}
