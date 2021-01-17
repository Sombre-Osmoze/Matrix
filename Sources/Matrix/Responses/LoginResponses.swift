//
//  LoginResponses.swift
//  Matrix
//
//  Created by Marcus Florentin on 13/06/2020.
//

import Foundation

// MARK: - Login Flow

public struct LoginFlowsResponse: ResponsesAPI {

	/// The homeserver's supported login types
	public let flows : [LoginFlow]
}

// MARK: - Login Response


public struct LoginResponse : ResponsesAPI {

	/// The fully-qualified Matrix ID that has been registered.
	public let userID : MatrixID

	/// An access token for the account. This access token can then be used to authorize other requests.
	public let accessToken : String

	@available(*, deprecated,
	renamed: "userID.hostname",
	message: "Clients should extract the server_name from user_id if they require it.")
	/// The server_name of the homeserver on which the account has been registered.
	public let homeServer : String?

	/// ID of the logged-in device. Will be the same as the corresponding parameter in the request, if one was specified.
	public let deviceID : String


	/// Optional client configuration provided by the server.
	/// If present, clients SHOULD use the provided object to reconfigure themselves, optionally validating the URLs within.
	/// This object takes the same form as the one returned from .well-known autodiscovery.
	public let wellKnown : DiscoveryInformation?

	public enum CodingKeys: String, CodingKey {
		case userID = "userId"
		case accessToken
		case homeServer
		case deviceID = "deviceId"
		case wellKnown
	}

}
