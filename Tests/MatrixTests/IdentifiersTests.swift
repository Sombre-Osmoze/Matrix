//
//  IdentifiersTests.swift
//  MatrixClientTests
//
//  Created by Marcus Florentin on 17/05/2020.
//


import XCTest
@testable import Matrix

final class IdentifiersTests: XCTestCase {

	private let identifiersFolder : URL = {
		var url = resourceFolder
		url.appendPathComponent("Identifiers")
		return url
	}()

	// MARK: - User identifier

	func testUserIdentifierDecoding() throws {

		let data = try file(named: "user_identifier", in: identifiersFolder)


		var identifier : UserIdentifier? = nil
		XCTAssertNoThrow(identifier = try decoder.decode(UserIdentifier.self, from: data))


		XCTAssertEqual(identifier?.type, IdentifierType.user)
		XCTAssertEqual(identifier?.user.description, "@swift-testing:matrix.org")
	}


	func testUserIdentifierEncoding() throws {

		let data = try file(named: "user_identifier", in: identifiersFolder)


		var identifier : UserIdentifier? = nil
		XCTAssertNoThrow(identifier = try decoder.decode(UserIdentifier.self, from: data))

		if let identifier = identifier {
			XCTAssertNoThrow(try encoder.encode(identifier))
		} else {
			XCTFail("No identifier decoded")
		}

	}

	// MARK: - Third party identifier

	func test3DrdEmailIdentifierDecoding() throws {

		let data = try file(named: "user_email_identifier", in: identifiersFolder)


		var identifier : ThirdPartyIdentifier? = nil
		XCTAssertNoThrow(identifier = try decoder.decode(ThirdPartyIdentifier.self, from: data))


		XCTAssertEqual(identifier?.type, IdentifierType.thirdparty)
		XCTAssertEqual(identifier?.medium, .email)
		XCTAssertEqual(identifier?.address, "swift-testing@matrix.org")
	}


	func test3DrdEmailIdentifierEncoding() throws {

		let data = try file(named: "user_email_identifier", in: identifiersFolder)


		var identifier : ThirdPartyIdentifier? = nil
		XCTAssertNoThrow(identifier = try decoder.decode(ThirdPartyIdentifier.self, from: data))

		if let identifier = identifier {
			XCTAssertNoThrow(try encoder.encode(identifier))
		} else {
			XCTFail("No identifier decoded")
		}

	}

	func test3DrdMSISDNIdentifierDecoding() throws {

		let data = try file(named: "user_msisdn_identifier", in: identifiersFolder)


		var identifier : ThirdPartyIdentifier? = nil
		XCTAssertNoThrow(identifier = try decoder.decode(ThirdPartyIdentifier.self, from: data))


		XCTAssertEqual(identifier?.type, IdentifierType.thirdparty)
		XCTAssertEqual(identifier?.medium, .msisdn)
		XCTAssertEqual(identifier?.address, "918369110173")
	}


	func test3DrdMSISDNIdentifierEncoding() throws {

		let data = try file(named: "user_msisdn_identifier", in: identifiersFolder)


		var identifier : ThirdPartyIdentifier? = nil
		XCTAssertNoThrow(identifier = try decoder.decode(ThirdPartyIdentifier.self, from: data))

		if let identifier = identifier {
			XCTAssertNoThrow(try encoder.encode(identifier))
		} else {
			XCTFail("No identifier decoded")
		}

	}

	// MARK: - Phone identifier

	func testPhoneIdentifierDecoding() throws {

		let data = try file(named: "user_phone_identifier", in: identifiersFolder)


		var identifier : PhoneIdentifier? = nil
		XCTAssertNoThrow(identifier = try decoder.decode(PhoneIdentifier.self, from: data))


		XCTAssertEqual(identifier?.type, IdentifierType.phone)
		XCTAssertEqual(identifier?.country, "IN")
		XCTAssertEqual(identifier?.phone, "+918369110173")
	}


	func testPhoneIdentifierEncoding() throws {

		let data = try file(named: "user_phone_identifier", in: identifiersFolder)


		var identifier : PhoneIdentifier? = nil
		XCTAssertNoThrow(identifier = try decoder.decode(PhoneIdentifier.self, from: data))

		if let identifier = identifier {
			XCTAssertNoThrow(try encoder.encode(identifier))
		} else {
			XCTFail("No identifier decoded")
		}

	}


	// MARK: - Error


	static var allTests = [

		// User identifier
		("Test user identifier decoding", testUserIdentifierDecoding),
		("Test user identifer encoding", testUserIdentifierEncoding),

		// 3Drd party identifer
		("Test third party email identifier decoding", test3DrdEmailIdentifierDecoding),
		("Test third party email identifier encoding", test3DrdEmailIdentifierEncoding),
		("Test third party MSISDN identifier decoding", test3DrdMSISDNIdentifierDecoding),
		("Test third party MSISDN identifier encoding", test3DrdMSISDNIdentifierEncoding),

		// Phone identifier
		("Test user phone identifier decoding", testPhoneIdentifierDecoding),
		("Test user phone identifer encoding", testPhoneIdentifierEncoding),

	]
}
