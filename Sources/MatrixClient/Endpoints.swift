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

	static let clientPath = "/_matrix/client/"

	// MARK: - Endpoints

	private let protectionSpace : URLProtectionSpace

	/// Main URL components, which will be used to create the endpoints.
	let main : URLComponents

	init(protection space: URLProtectionSpace, version: MatrixClient.Version = .r0_6_0) {
		protectionSpace = space

		// Creating main URL components
		var components = URLComponents()
		components.host = protectionSpace.host
		components.port = protectionSpace.port
		components.scheme = protectionSpace.protocol

		switch version {
			case let r where MatrixClient.Version.r0.contains(r) :
				components.path = Self.clientPath + "r0/"

			default:
				components.path = Self.clientPath
		}

		main = components
	}

	// MARK: - Login

	/// Login endpoint.
	enum Authentications: String {
		/// `/login`
		case login
	}

	func authentication(_ endpoint: Authentications) -> URL? {
		var components = main
		components.path.append(endpoint.rawValue)
		return components.url
	}

}
