//
//  DecodingTests.swift
//  MatrixTests
//
//  Created by Marcus Florentin on 17/01/2021.
//

import XCTest
@testable import Matrix

final class DecodingTests: XCTestCase {

	private let decodingFolder : URL = {
		var url = resourceFolder
		url.appendPathComponent("Decoding")
		return url
	}()


    func testDiscoveryInformationDecoding() throws {

		let data = try file(named: "discovery_information", in: decodingFolder)

		XCTAssertNoThrow(try decoder.decode(DiscoveryInformation.self, from: data))
    }



}
