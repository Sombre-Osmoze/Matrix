//
//  Endpoints.swift
//  MatrixClient
//
//  Created by Marcus Florentin on 11/05/2020.
//

import Foundation


struct Endpoints {
	// MARK: - Endpoints Structure

	static func version(protection space: URLProtectionSpace) -> URL? {
		var components = URLComponents()
		components.host = space.host
		components.port = space.port
		components.scheme = space.protocol
		components.path = "\(clientPath)versions"
		return components.url
	}

	private static let clientPath = "/_matrix/client/"

	// MARK: - Endpoints

	enum Version : String {
		case r0_0_1 = "r0.0.1"
		case r0_1_0 = "r0.1.0"
		case r0_2_0 = "r0.2.0"
		case r0_3_0 = "r0.3.0"
		case r0_4_0 = "r0.4.0"
		case r0_5_0 = "r0.5.0"
		case r0_6_0 = "r0.6.0"
	}

	private let protectionSpace : URLProtectionSpace

	init(protection space: URLProtectionSpace, version: Version = .r0_6_0) {
		protectionSpace = space
	}

	func main() -> URLComponents {
		var components = URLComponents()
		components.host = protectionSpace.host
		components.port = protectionSpace.port
		components.scheme = protectionSpace.protocol
		components.path = Endpoints.clientPath

		return components
	}


	// MARK: Login

	/// Login endpoint.
	enum Login: String {
		/// `/login`
		case login
	}


}
