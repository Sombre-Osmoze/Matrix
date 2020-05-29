//
//  MatrixClientTests.swift
//  MatrixClientTests
//
//  Created by Marcus Florentin on 12/05/2020.
//

import XCTest
@testable import MatrixClient

let protectionSpace : URLProtectionSpace = .init(host: "matrix.org", port: 443, protocol: "https", realm: nil, authenticationMethod: nil)

final class MatrixClientTests: XCTestCase {

	private let client : MatrixClient = .init(protection: protectionSpace, operation: .main)


	// MARK: - Login

	func testLoginFlows() {

		let requestExpectation = XCTestExpectation(description: "Login flows request")

		client.loginFlows { result in
			switch result {
				case .success(let flows):
					print(flows.debugDescription)
				case .failure(let error):

					XCTFail((error as? ResponseError)?.error ?? "")
			}

			requestExpectation.fulfill()
		}.resume()

		wait(for: [requestExpectation], timeout: 10)
	}

    static var allTests = [
        ("testLoginFlows", testLoginFlows),
    ]
}

// MARK: - Test Resources

internal let resourceFolder : URL = {
	var url = URL(fileURLWithPath: #file)
	url.deletePathExtension()
	url.deleteLastPathComponent()
	url.appendPathComponent("Resources")
	return url
}()

internal func file(named name: String, extention: String? = "json", in folder: URL = resourceFolder) throws -> Data {
	var url = folder
	url.appendPathComponent(name)

	if let extention = extention {
		url.appendPathExtension(extention)
	}

	return try Data(contentsOf: url)
}
