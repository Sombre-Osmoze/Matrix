//
//  LoginRequests.swift
//  Matrix
//
//  Created by Marcus Florentin on 13/06/2020.
//

import Foundation


public protocol LoginRequest: RequestsAPI {

	var type : LoginFlow.Flow { get }

	var deviceID : DeviceID? { get set }
}

public struct LoginPasswordRequest: LoginRequest {

	public let type : LoginFlow.Flow = .password

	public let identifier : Identifier

	public let password : String

	public var deviceID: DeviceID? = nil
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
		case deviceID = "device_id"
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
		deviceID = try container.decode(DeviceID.self, forKey: .deviceID)
		identifier = try container.decodeIdentifier(forKey: .identifier)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(type, forKey: .type)
		try container.encode(password, forKey: .password)
		try container.encode(initialDeviceName, forKey: .initialDeviceName)
		try container.encode(deviceID, forKey: .deviceID)
		try container.encodeIdentifier(identifier, forKey: .identifier)
	}

}
