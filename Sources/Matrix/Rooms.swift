//
//  Rooms.swift
//  Matrix
//
//  Created by Marcus Florentin on 18/04/2021.
//

import Foundation


public struct RoomID: Codable, Hashable, Equatable, ExpressibleByStringLiteral {


	/// The `roomname`.
	public let roomname : String

	/// The `hostname` where the room is registered.
	public let host : String

	public let description : String

	public let debugDescription : String

	/// Create a `Matrix` identifer with given roomname and host
	/// - Parameters:
	///   - room: The roomname of th identifier
	///   - host: The server name of the identifier
	public init(roomname: String, hostname: String) {
		self.roomname = roomname
		self.host = hostname
		self.description = "!\(roomname):\(hostname)"
		self.debugDescription = "\(description): { room : \(roomname), host: \(host) "
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

		guard let atIndex = value.firstIndex(of: "!"), let semiIndex = value.firstIndex(of: ":") else {
			// TODO: Handle error and create failable initializer
			fatalError("No ! or :")
		}


		/// The roomname is between `@` and `:`
		let room = String(value[(value.index(after: atIndex))..<semiIndex])
		/// The hostname is all that is after `:`
		let host = String(value[(value.index(after: semiIndex))...])

		self.init(roomname: room, hostname: host)
	}
}
