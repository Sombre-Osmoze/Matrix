//
//  EndpointsTests.swift
//  MatrixClientTests
//
//  Created by Marcus Florentin on 11/05/2020.
//

import XCTest
@testable import MatrixClient

final class EndpointsTests: XCTestCase {

	private let version : Endpoints.Version = .r0_6_0

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
			XCTFail("Impossible to create main URL")
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
		guard let url = endpoints.authentication(.login) else {
			XCTFail("Impossible to create login URL")
			return
		}

		XCTAssertEqual(url.path, basePath + "/login",
					   "Invalid path for login URL")
	}


	static var allTests = [
		("Test endpoint version", testVersionEndpoint),
		("Test main url", testMainURL),
	]
}
