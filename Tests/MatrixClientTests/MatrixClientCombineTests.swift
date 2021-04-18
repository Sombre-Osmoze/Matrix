//
//  MatrixClientCombineTests.swift
//  MatrixClientTests
//
//  Created by Marcus Florentin on 29/05/2020.
//

import Foundation


import XCTest
@testable import MatrixClient

#if canImport(Combine)
import Combine

final class MatrixClientCombineTests: XCTestCase {

	private let client : MatrixClient = .init(protection: protectionSpace, operation: .main, logger: .init(label: "test-client.matrix.org"))



	func testCombineLoginFlows() {

		let requestExpectation = XCTestExpectation(description: "Login flows request")

		client.loginFlows()
			.sink(receiveCompletion: { completion in
				self.handle(completion: completion)
				requestExpectation.fulfill()
			}) { flows in
				print(flows.debugDescription)
		}
			.store(in: &publishers)

		wait(for: [requestExpectation], timeout: 10)
	}


	func testCombineLogin() throws {
		let requestData : Data = try file(named: "login_password_request")
		let request = try decoder.decode(LoginPasswordRequest.self, from: requestData)

		let requestExpectation = XCTestExpectation(description: "Login request")

		try client.login(request)
			.sink(receiveCompletion: { completion in
				self.handle(completion: completion)
				requestExpectation.fulfill()
			}){ response in
				XCTAssertEqual(response.userID, (request.identifier as? UserIdentifier)?.user)
			}
			.store(in: &publishers)

		wait(for: [requestExpectation], timeout: 10)
	}

	// MARK: - Completion & Errors

	private var publishers : [AnyCancellable] = []

	override func tearDown() {
		super.tearDown()

		publishers.removeAll()
	}


	/// Handle a subscriber completion event.
	/// - Parameter completion: The completion event ever finished or failed.
	func handle(completion: Subscribers.Completion<Error>) -> Void {
		switch completion {
		case .finished:
			break;
		case .failure(let error):
			XCTFail(error.localizedDescription)
		}
	}



	static var allTests = [
		("testLoginFlows", testCombineLoginFlows),
		("Test Login", testCombineLogin),
	]
}

#endif


