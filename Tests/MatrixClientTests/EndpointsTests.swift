//
//  EndpointsTests.swift
//  MatrixClientTests
//
//  Created by Marcus Florentin on 11/05/2020.
//

import XCTest
@testable import MatrixClient

final class EndpointsTests: XCTestCase {

	private let version : MatrixClient.Version = .r0_6_0

	private let endpoints : Endpoints = .init(protection: protectionSpace)

	private let basePath : String = Endpoints.clientPath + "r0"

	// MARK: - Endpoint

	func testVersionEndpoint() {
		let url = Endpoints.version(protection: protectionSpace)

		XCTAssertEqual(url?.path, "/_matrix/client/versions",
					   "Matrix client version path is invalid")
	}

	func testMainURL() {
		guard let main = endpoints.main.url else {
			failedTorCreate(url: "main")
			return
		}


		XCTAssertEqual(main.host, protectionSpace.host,
					   "Main URL host is invalid")

		XCTAssertEqual(main.scheme, protectionSpace.protocol,
					   "Main URL protocol is invalid")

		XCTAssertEqual(main.port, protectionSpace.port,
					   "Main URL port is invalid")

		XCTAssertEqual(main.path, basePath,
					   "Main URL path is invalid")

	}

	// MARK: - Login
	func testLogin() {
		let urlPath = "/login"

		guard let url = endpoints.authentication(.login) else {
			failedTorCreate(url: "login")
			return
		}

		XCTAssertEqual(url.path, basePath + urlPath,
					   invalidPathFor(url: urlPath))
	}

	// MARK: - Rooms

	func testJoinedRooms() {
		let urlPath = "/joined_rooms"

		guard let url = endpoints.rooms(.joinedRooms) else {
			failedTorCreate(url: "joined rooms")
			return
		}

		XCTAssertEqual(url.path, basePath + urlPath,
					   invalidPathFor(url: urlPath))
	}


	// MARK: - Misc

	private func failedTorCreate(url: String) -> Void {
		XCTFail("Impossible to create \(url) URL")
	}

	private func invalidPathFor(url: String) -> String {
		"Invalid path for \(url) URL"
	}

	static var allTests = [
		("Test endpoint version", testVersionEndpoint),
		("Test main url", testMainURL),
	]
}
