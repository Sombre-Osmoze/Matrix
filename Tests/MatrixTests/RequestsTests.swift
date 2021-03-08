//
//  RequestsTests.swift
//  MatrixTests
//
//  Created by Marcus Florentin on 01/06/2020.
//

import XCTest
@testable import Matrix

class RequestsTests: XCTestCase {

	let responsesFolder : URL = {
		var url = resourceFolder
		url.appendPathComponent("Requests")
		return url
	}()


	// MARK: - Login

	func testLoginPasswordRequestdecoding() throws {
		let data = try file(named: "login_password_request", in: responsesFolder)


		var request : LoginPasswordRequest!
		XCTAssertNoThrow(request = try decoder.decode(LoginPasswordRequest.self, from: data))

		guard let requestSafe = request else { return }

		XCTAssertEqual(requestSafe.type, .password)
		XCTAssertEqual(requestSafe.password, "Swift4L!f3")
		XCTAssertEqual(requestSafe.initialDeviceName, "Swift-Package")

		if let identifier = requestSafe.identifier as? UserIdentifier {
			XCTAssertEqual(identifier.type, .user)
			XCTAssertEqual(identifier.user, "@swift-testing:matrix.org")

		} else {
			XCTFail("Can't create user identifier got type: \(requestSafe.identifier.type)")
		}

	}

	static var allTests = [
		("Test login password request decoding", testLoginPasswordRequestdecoding),

	]
}
