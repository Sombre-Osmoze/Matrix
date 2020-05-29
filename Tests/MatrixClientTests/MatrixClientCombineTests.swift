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

	private let client : MatrixClient = .init(protection: protectionSpace, operation: .main)



	func testCombineLoginFlows() {

		let requestExpectation = XCTestExpectation(description: "Login flows request")

		let publisher = client.loginFlows()
			.sink(receiveCompletion: { completion in
				self.handle(completion: completion)
				requestExpectation.fulfill()
			}) { flows in
				print(flows.debugDescription)
		}


		publishers.append(publisher)

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
	]
}

#endif


