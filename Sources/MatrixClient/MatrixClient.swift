//
//  MatrixClient.swift
//  MatrixClient
//
//  Created by Marcus Florentin on 11/05/2020.
//

import Foundation
@_exported import Matrix

#if canImport(Combine)
import Combine
#endif

// MARK: - Matrix Client Class

public class MatrixClient {

	static let matrix : URLProtectionSpace = .init(host: "matrix.org", port: 443, protocol: "https",
												   realm: nil, authenticationMethod: nil)


	// MARK: - Matrix Client

	/// Actual version used by the client.
	public let version : Version

	/// Versions of the specification supported by the server.
	///
	/// Values will take the form `rX.Y.Z.`
	public enum Version : String, CaseIterable, Codable {

		case r0_0_1 = "r0.0.1"
		case r0_1_0 = "r0.1.0"
		case r0_2_0 = "r0.2.0"
		case r0_3_0 = "r0.3.0"
		case r0_4_0 = "r0.4.0"
		case r0_5_0 = "r0.5.0"
		case r0_6_0 = "r0.6.0"

		/// r0 Major version
		public static let r0 : Set<Version> = [.r0_0_1, .r0_2_0, .r0_3_0,
											   .r0_4_0, .r0_5_0, .r0_6_0]
	}


	/// Gets the versions of the specification supported by the server.
	/// - note: The server may additionally advertise experimental features it supports through `unstable_features`.
	/// These features should be namespaced and may optionally include version information within their name if desired.
	/// Features listed here are not for optionally toggling parts of the Matrix specification and should only be used to advertise support for a feature which has not yet landed in the spec.
	/// For example, a feature currently undergoing the proposal process may appear here and eventually be taken off this list once the feature lands in the spec and the server deems it reasonable to do so.
	/// Servers may wish to keep advertising features here after they've been released into the spec to give clients a chance to upgrade appropriately.
	/// Additionally, clients should avoid using unstable features in their stable releases.
	public struct ClientSupport: Codable {

		/// The supported versions.
		public let versions : Set<Version>

		/// Experimental features the server supports.
		/// Features not listed here, or the lack of this property all together, indicate that a feature is not supported.
		public let unstableFeatures : [String : Bool]?
	}




	/// Create a Matrix client for the given configuration.
	/// - Parameters:
	///   - version: The version of the endpoints to handle.
	///   - space: The protection space of the `homeserver`.
	///   - queue: The operation queue where the network request will be runned.
	///   - delegate: The `URLSessionDelegate` for the `URLSession`.
	public init(_ version: Version = .r0_6_0,
		 protection space: URLProtectionSpace,
		 operation queue: OperationQueue,
		 session delegate: URLSessionDelegate? = nil) {

		self.version = version

		// Creating requests session and its queue
		operationQueue = queue
		session = .init(configuration: .default, delegate: delegate, delegateQueue: operationQueue)
		session.sessionDescription = operationQueue.name

		// Creating endpoints
		endpoints = .init(protection: space, version: version)
	}


	/// Create a default Matrix client.
	public convenience init() {
		let queue = OperationQueue()
		queue.qualityOfService = .userInitiated
		queue.name = "xyz.osmoze.MatrixClient"

		self.init(protection: MatrixClient.matrix, operation: queue)
	}



	// MARK: - Session & Requests

	// MARK: - Session

	public let session : URLSession

	public let operationQueue : OperationQueue

	private let endpoints : Endpoints

	// MARK: - Request

	/// This function will check the callback of a DataTaskRequest and will verify the satuts code.
	private func verify(_ response: URLResponse?, _ error: Error?, log: StaticString) throws -> HTTPURLResponse {

		// If a error occurred throw it
		if let error = error {
			throw error
		}

		// Checking if the request have a response
		guard response != nil else { throw RequestError.Response.noResponse }

		// Checking if the response is a HTTP response
		guard let answer = response as? HTTPURLResponse else { throw RequestError.Response.corrupted }

		// TODO: Verify status code

		return answer
	}

	private func validate<T: Codable>(response: HTTPURLResponse, data: Data?, for type: T.Type = T.self, log: StaticString) throws -> T {

		guard let data = data else { throw RequestError.noData }

		// Checking if the content body is the size expected in the header
		guard data.count == Int(response.expectedContentLength) else {
			throw RequestError.dataCorrupted(expected: Int(response.expectedContentLength), received: data.count)
		}

		if let api = try? decoder.decode(ResponseError.self, from: data) {
			throw api
		} else {
			return try decoder.decode(T.self, from: data)
		}
	}


	#if canImport(Combine)

	private func verify(task publisher: URLSession.DataTaskPublisher, log: StaticString) -> AnyPublisher<(Data, HTTPURLResponse), Error> {

		// Verify the response and decoding the data.
		publisher.tryMap { data, urlResponse -> (Data, HTTPURLResponse) in
			let response = try self.verify(urlResponse, nil, log: log)
			return (data, response)
		}
		.eraseToAnyPublisher()
	}

	private func validate<T: Codable>(_ publisher: AnyPublisher<(Data, HTTPURLResponse), Error>,
									  for type: T.Type = T.self, log: StaticString) -> AnyPublisher<T, Error> {

		// Try mapping data to expected type
		publisher.tryMap { data, response -> T in
			return try self.validate(response: response, data: data, log: log)
		}
		.eraseToAnyPublisher()
	}

	#endif


	// MARK: - Authentications



	// MARK: Login

	// Login Flows
	let loginFlowsLog : StaticString = "Login flows request"

	/// Gets the homeserver's supported login types to authenticate users.
	/// Clients should pick one of these and supply it as the `type` when logging in.
	/// - Parameter handler: A closure call when the request is terminated.
	/// - Returns: A progress object for the `URLDataTask`.
	func loginFlows(completion handler: @escaping(Result<[LoginFlow], Error>) -> Void) -> Progress {
		/// `/login`
		let url : URL = endpoints.authentication(.login)!

		/// The data task for this request
		let task = session.dataTask(with: url) { unsafeData, reponse, error in
			do {
				let httpResponse = try self.verify(reponse, error, log: self.loginFlowsLog)

				let loginResponses : LoginResponse = try self.validate(response: httpResponse,
																	   data: unsafeData, log: self.loginFlowsLog)

				handler(.success(loginResponses.flows))

			} catch {
				handler(.failure(error))
			}
		}

		return task.progress
	}

	#if canImport(Combine)

	func loginFlows() -> AnyPublisher<[LoginFlow], Error> {
		/// `/login`
		let url : URL = endpoints.authentication(.login)!


		let task = session.dataTaskPublisher(for: url)
		let verified = verify(task: task, log: loginFlowsLog)

		return validate(verified, for: LoginResponse.self, log: loginFlowsLog)
			.map(\.flows)
		.eraseToAnyPublisher()
	}

	#endif


	// MARK: - Error

	public enum RequestError: Error {
		case noURL

		public enum Response: Error {
			case noResponse
			case corrupted
		}
		case noData
		case dataCorrupted(expected: Int, received: Int)
	}

}
