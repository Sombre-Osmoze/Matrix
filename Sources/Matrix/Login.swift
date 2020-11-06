//
//  Login.swift
//  Matrix
//
//  Created by Marcus Florentin on 29/05/2020.
//

import Foundation

// MARK: - Login


/// A home server supported login
public struct LoginFlow: Codable {

	/// The login type.
	/// This is supplied as the `type` when logging in.
	public let type : Flow

	public enum Flow : Codable, CaseIterable, Equatable {
		public static var allCases: [LoginFlow.Flow] = [.password]
		public typealias AllCases = [Flow]

		case password
		case unknown(id: String)

		public var rawValue: String {
			switch self {
				case .password:
					return "m.login.password"
				case .unknown(id: let unknown):
					return unknown
			}
		}

		init(rawValue: String) {
			switch rawValue {
				case "m.login.password":
					self = .password
				default:
					self = .unknown(id: rawValue)
			}
		}

		// Codable

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			let rawValue = try container.decode(String.self)
			self = .init(rawValue: rawValue)
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()

			try container.encode(rawValue)
		}

	}
}

