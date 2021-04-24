//
//  RoomsTests.swift
//  MatrixTests
//
//  Created by Marcus Florentin on 24/04/2021.
//

import XCTest
@testable import Matrix

class RoomsTests: XCTestCase {


	// MARK: - Room ID Tests

	func testRoomIDCreation() {
		let identifier = RoomID(roomname: "chat", hostname: "matrix.org")

		XCTAssertEqual(identifier.description, "!chat:matrix.org")

	}

	func testRoomIDCreationStringLiteral() {
		let identifier : RoomID = "!chat:matrix.org"

		XCTAssertEqual(identifier.description, "!chat:matrix.org")

	}

	// MARK: Codable

	func testRoomIDCoding() {
		let identifier = RoomID(roomname: "chat", hostname: "matrix.org")

		var data : Data!

		XCTAssertNoThrow(data = try encoder.encode(identifier),
						 "Can't encode Room ID")


		var extractID : RoomID!
		XCTAssertNoThrow(extractID = try decoder.decode(RoomID.self, from: data),
						 "Can't decode a Room ID")


		XCTAssertEqual(extractID, identifier, "The decoded identifier is not valid")
	}

	// MARK: Encoding

	func testRoomIDEncoding() {
		let identifier = RoomID(roomname: "chat", hostname: "matrix.org")

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

	func testRoomIDDecoding() {
		let roomname = "chat"
		let hostname = "matrix.org"

		let data = "\"!\(roomname):\(hostname)\"".data(using: .utf8)!


		var identifier : RoomID? = nil
		XCTAssertNoThrow(identifier = try decoder.decode(RoomID.self, from: data))

		XCTAssertEqual(identifier?.roomname, roomname)
		XCTAssertNoThrow(identifier?.host, hostname)
	}


	static var allTests = [
		// Matrix ID
		("Test Room ID creation", testRoomIDCreation),
		("Test Matrix ID creation from String literals", testRoomIDCreationStringLiteral),

		// Coding
		("Test Matrix ID coding", testRoomIDCoding),
		// Encoding
		("Test Matrix ID encoding", testRoomIDEncoding),
		// Decoding
		("Test Matrix ID decoding", testRoomIDDecoding),

	]
}
