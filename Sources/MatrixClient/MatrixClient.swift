//
//  MatrixClient.swift
//  MatrixClient
//
//  Created by Marcus Florentin on 11/05/2020.
//

import Foundation
@_exported import Matrix

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



	// MARK: - Session & Resuests

	private let session : URLSession

	private let operationQueue : OperationQueue

	private let endpoints : Endpoints


}
