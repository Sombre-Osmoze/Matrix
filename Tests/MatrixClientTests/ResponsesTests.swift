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


	// MARK: - Error


	func testErrorDecoding() throws {
		let data = try file(named: "error_unrecognized", in: responsesFolder)

		var error : ErrorResponse!

		XCTAssertNoThrow(error = try decoder.decode(ErrorResponse.self, from: data))

		XCTAssertEqual(error.code, ErrorResponse.Code.unrecognized)
		XCTAssertEqual(error.domain, "M")
	}

	static var allTests = [
		("Test login response decoding", testLoginResponseDecoding),
	]
}
