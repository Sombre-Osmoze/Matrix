//
//  Others.swift
//  Matrix
//
//  Created by Marcus Florentin on 18/08/2020.
//

import Foundation

public struct DiscoveryInformation: Codable {

	public struct ServerInformations : Codable {
		public let baseURL : URL?
	}

	/// Used by clients to discover homeserver information.
	public let homeServer : ServerInformations

	/// Used by clients to discover identity server information.
	public let identifyServer : ServerInformations?

	public enum CodingKeys: String, CodingKey {
		case homeServer = "m.homeserver"
		case identifyServer = "m.identity_server"
	}
}
