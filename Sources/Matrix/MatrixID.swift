//
//  MatrixID.swift
//  Matrix
//
//  Created by Marcus Florentin on 12/05/2020.
//

import Foundation

// TODO: Move structure to class

public struct MatrixID : Codable, Hashable, Equatable, ExpressibleByStringLiteral {


	/// The `username`.
	public let username : String

	/// The `hostname` where the user is registered.
	public let host : String

	public let description : String

	public let debugDescription : String

	/// Create a `Matrix` identifer with given username and host
	/// - Parameters:
	///   - username: The username of th identifier
	///   - host: The server name of the identifier
	public init(username: String, hostname: String) {
		self.username = username
		self.host = hostname
		self.description = "@\(username):\(hostname)"
		self.debugDescription = "\(description): { username : \(username), host: \(host) "
	}

	// MARK: - Codable

	// MARK: Encodable

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(description)
	}


	// MARK: Decodable

	public init(from decoder: Decoder) throws {
		let container: SingleValueDecodingContainer = try decoder.singleValueContainer()
		let identifier : String = try container.decode(String.self)

		self.init(stringLiteral: identifier)
	}

	// MARK: - String Literal

	public typealias StringLiteralType = String

	public init(stringLiteral value: String) {

		guard let atIndex = value.firstIndex(of: "@"), let semiIndex = value.firstIndex(of: ":") else {
			// TODO: Handle error and create failable initializer
			fatalError("No @ or :")
		}


		/// The username is between `@` and `:`
		let user = String(value[(value.index(after: atIndex))..<semiIndex])
		/// The hostname is all that is after `:`
		let host = String(value[(value.index(after: semiIndex))...])

		self.init(username: user, hostname: host)
	}
}
