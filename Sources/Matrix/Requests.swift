//
//  Requests.swift
//  Matrix
//
//  Created by Marcus Florentin on 29/05/2020.
//

import Foundation

// MARK: - Requests

/// The common protocol of all the request sent by the client.
public protocol RequestsAPI: Codable { }


// MARK: - Login


public protocol LoginRequest: RequestsAPI {

	var type : LoginFlow.Flow { get }

}

public struct LoginPasswordRequest: LoginRequest {

	public let type : LoginFlow.Flow = .password

	public let identifier : Identifier

	public let password : String

	public let initialDeviceName : String


	public init(_ identifier: Identifier, password: String, device name: String) {

		self.identifier = identifier
		self.password = password
		self.initialDeviceName = name
	}

	// Codable
	public enum CodingKeys: String, CodingKey {
		case type
		case identifier
		case password
		case initialDeviceName = "initial_device_display_name"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let decodedType = try container.decode(LoginFlow.Flow.self, forKey: .type)
		guard decodedType == type else {
			throw DecodingError.dataCorruptedError(forKey: CodingKeys.type, in: container,
												   debugDescription: "Type value equal to \(decodedType) expecting \(type)")
		}


		password = try container.decode(String.self, forKey: .password)
		initialDeviceName = try container.decode(String.self, forKey: .initialDeviceName)
		identifier = try container.decodeIdentifier(forKey: .identifier)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(type, forKey: .type)
		try container.encode(password, forKey: .password)
		try container.encode(initialDeviceName, forKey: .initialDeviceName)
		try container.encodeIdentifier(identifier, forKey: .identifier)
	}

}
