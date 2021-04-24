//
//  MatrixIDTests.swift
//  MatrixTests
//
//  Created by Marcus Florentin on 12/05/2020.
//

import XCTest
@testable import Matrix

final class MatrixIDTests: XCTestCase {

	func testMatrixIDCreation() {
		let identifier = MatrixID(username: "osmoze", hostname: "matrix.org")

		XCTAssertEqual(identifier.description, "@osmoze:matrix.org")

	}

	func testMatrixIDCreationStringLiteral() {
		let identifier = MatrixID(stringLiteral: "@osmoze:matrix.org")

		XCTAssertEqual(identifier.description, "@osmoze:matrix.org")

	}

	// MARK: - Codable

	func testMatrixIDCoding() {
		let identifier = MatrixID(username: "osmoze", hostname: "matrix.org")

		var data : Data!

		XCTAssertNoThrow(data = try encoder.encode(identifier),
						 "Can't encode Matrix ID")


		var extractID : MatrixID!
		XCTAssertNoThrow(extractID = try decoder.decode(MatrixID.self, from: data),
						 "Can't decode a Matrix ID")


		XCTAssertEqual(extractID, identifier, "The decoded identifier is not valid")
	}

	// MARK: Encoding

	func testMatrixIDEncoding() {
		let identifier = MatrixID(username: "alice", hostname: "matrix.org")

		var data : Data? = nil
		XCTAssertNoThrow(data = try encoder.encode(identifier),
						 "Can't encode Matrix ID")

		guard data != nil, let text = String(data: data!, encoding: .utf8) else {
			return XCTFail("Can't create string with data")
		}

		XCTAssertEqual(text, "\"\(identifier.description)\"",
					   "Encoded text is invalid")
	}


	// MARK: Decoding

	func testMatrixIDDecoding() {
		let username = "bob"
		let hostname = "matrix.org"

		let data = "\"@\(username):\(hostname)\"".data(using: .utf8)!


		var identifier : MatrixID? = nil
		XCTAssertNoThrow(identifier = try decoder.decode(MatrixID.self, from: data))

		XCTAssertEqual(identifier?.username, username)
		XCTAssertNoThrow(identifier?.host, hostname)
	}


	static var allTests = [
		// Matrix ID
		("Test Matrix ID creation", testMatrixIDCreation),
		("Test Matrix ID creation from String literals", testMatrixIDCreationStringLiteral),

		// Coding
		("Test Matrix ID coding", testMatrixIDCoding),
		// Encoding
		("Test Matrix ID encoding", testMatrixIDEncoding),
		// Decoding
		("Test Matrix ID decoding", testMatrixIDDecoding),

	]
}
