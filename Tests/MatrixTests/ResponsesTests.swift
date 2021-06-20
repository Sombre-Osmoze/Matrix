//
//  ResponsesTests.swift
//  MatrixTests
//
//  Created by Marcus Florentin on 17/05/2020.
//


import XCTest
@testable import Matrix

fileprivate let responseFolderName = "Responses"

final class ResponsesTests: XCTestCase {

	let responsesFolder : URL = {
		var url = resourceFolder
		url.appendPathComponent(responseFolderName)
		return url
	}()

	// MARK: - Login

	func testLoginFlowsResponseDecoding() throws {

		let data = try file(named: "login_flows_request", in: responsesFolder)


		XCTAssertNoThrow(try decoder.decode(LoginFlowsResponse.self, from: data))

	}

	/// Test the login response decoding.
	func testLoginResponseDecoding() throws {

		let data = try file(named: "login_response", in: responsesFolder)


		XCTAssertNoThrow(try decoder.decode(LoginResponse.self, from: data))
	}


	// MARK: - Rooms

	private let roomsResponseFolder : URL = {
		var url = resourceFolder
		url.appendPathComponent(responseFolderName)
		url.appendPathComponent("Rooms")
		return url
	}()

	func testJoinedRoomsResponseDecoding() throws {
		let data = try file(named: "joined_rooms_response", in: roomsResponseFolder)

		XCTAssertNoThrow(try decoder.decode(JoinedRoomResponse.self, from: data))
	}


	// MARK: - Error


	func testErrorDecoding() throws {
		let data = try file(named: "error_unrecognized", in: responsesFolder)

		var error : ResponseError?

		XCTAssertNoThrow(error = try decoder.decode(ResponseError.self, from: data))

		XCTAssertEqual(error?.code, ResponseError.Code.unrecognized)
		XCTAssertEqual(error?.domain, "M")
	}

	static var allTests = [
		("Test login flows response decoding", testLoginFlowsResponseDecoding),
		("Test login response decoding", testLoginResponseDecoding),
		("Test error decoding", testErrorDecoding),
	]
}
