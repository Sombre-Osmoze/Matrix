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

	public let homeServer : ServerInformations?

	public let identifyServer : ServerInformations?

}
