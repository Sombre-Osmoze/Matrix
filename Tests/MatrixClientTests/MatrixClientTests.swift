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
