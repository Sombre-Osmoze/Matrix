//
//  Responses.swift.swift
//  MatrixClient
//
//  Created by Marcus Florentin on 12/05/2020.
//

import Foundation


// MARK: - Responses


/// The common protocol of all the responses return by a server.
protocol ResponsesAPI: Codable { }


// MARK: - Error Responses


/// Any errors which occur at the Matrix API level MUST return a "standard error response".
///
/// The `error` string will be a human-readable error message, usually a sentence explaining what went wrong.
/// The `errcode` string will be a unique string which can be used to handle an error message e.g.
/// `M_FORBIDDEN`. These error codes should have their namespace first in ALL CAPS, followed by a single "__" to ease separating the namespace from the error code.
/// For example, if there was a custom namespace `com.mydomain.here`, and a `FORBIDDEN` code, the error code should look like `COM.MYDOMAIN.HERE_FORBIDDEN`.
/// There may be additional keys depending on the error, but the keys `error` and `errcode` MUST always be present.
///
/// - note: Errors are generally best expressed by their error code rather than the HTTP status code returned. When encountering the error code `M_UNKNOWN`, clients should prefer the HTTP status code as a more reliable reference for what the issue was. For example, if the client receives an error code of `M_NOT_FOUND` but the request gave a 400 Bad Request status code, the client should treat the error as if the resource was not found. However, if the client were to receive an error code of `M_UNKNOWN` with a 400 Bad Request, the client should assume that the request being made was invalid.
public struct ErrorResponse: ResponsesAPI {

	public let domain : String?

	public let code : Code

	public let error : String

	// Coding

	enum CodingKeys: String, CodingKey {
		case code = "errcode"
		case error
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Self.CodingKeys)

		// Code decoding
		let errcode : String = try container.decode(String.self, forKey: .code)
		guard let separatorIndex = errcode.firstIndex(of: "_") else {
			throw DecodingError.dataCorruptedError(forKey: Self.CodingKeys.code,
												   in: container,
												   debugDescription: "No separator \"_\" found in \(errcode)")
		}

		let domainSub = errcode[errcode.startIndex..<separatorIndex]
		domain = String(domainSub)

		code = Code(rawValue: errcode.replacingOccurrences(of: domainSub, with: "M")) ?? .unknown

		error = try container.decode(String.self, forKey: .error)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: Self.CodingKeys)
		try container.encode(code, forKey: .code)
		try container.encode(error, forKey: .error)
	}


	public enum Code: String, Codable {
		// The common error codes

		/// Forbidden access, e.g. joining a room without permission, failed login.
		case forbidden = "M_FORBIDDEN"

		/// The access token specified was not recognised.
		case unknownToken = "M_UNKNOWN_TOKEN"

		/// No access token was specified for the request.
		case missingToken = "M_MISSING_TOKEN"

		/// Request contained valid JSON, but it was malformed in some way.
		/// - Example: Missing required keys, invalid values for keys.
		case M_BAD_JSON = "M_BAD_JSON"

		/// Request did not contain valid JSON.
		case notJSON = "M_NOT_JSON"

		/// No resource was found for this request.
		case notFound = "M_NOT_FOUND"

		/// Too many requests have been sent in a short period of time.
		/// Wait a while then try again.
		case limitExceeded = "M_LIMIT_EXCEEDED"

		/// An unknown error has occurred.
		case unknown = "M_UNKNOWN"

		// Other error codes the client might encounter

		/// The server did not understand the request.
		case unrecognized = "M_UNRECOGNIZED"

		/// The request was not correctly authorized.
		/// Usually due to login failures.
		case unauthorized = "M_UNAUTHORIZED"

		/// The user ID associated with the request has been deactivated.
		/// Typically for endpoints that prove authentication, such as `/login`.
		case userDeactivated = "M_USER_DEACTIVATED"

		/// Encountered when trying to register a user ID which has been taken.
		case userInUser = "M_USER_IN_USE"

		/// Encountered when trying to register a user ID which is not valid.
		case invalidUsername = "M_INVALID_USERNAME"

		/// Sent when the room alias given to the `createRoom` API is already in use.
		case roomInUse = "M_ROOM_IN_USE"

		/// Sent when the initial state given to the `createRoom` API is invalid.
		case invalidRoomState = "M_INVALID_ROOM_STATE"

		/// Sent when a threepid given to an API cannot be used because the same threepid is already in use.
		case threepidInUse = "M_THREEPID_IN_USE"

		/// Sent when a threepid given to an API cannot be used because no record matching the threepid was found.
		case threepidNotFound = "M_THREEPID_NOT_FOUND"

		/// Authentication could not be performed on the third party identifier.
		case threepidAuthFailed = "M_THREEPID_AUTH_FAILED"

		/// The server does not permit this third party identifier.
		/// This may happen if the server only permits, for example, email addresses from a particular domain.
		case threepidDenied = "M_THREEPID_DENIED"

		/// The client's request used a third party server.
		/// - Exemple: Identity server, that this server does not trust.
		case serverNotTrusted = "M_SERVER_NOT_TRUSTED"

		/// The client's request to create a room used a room version that the server does not support.
		case unsupportedRoomVersion = "M_UNSUPPORTED_ROOM_VERSION"

		/// The client attempted to join a room that has a version the server does not support.
		/// Inspect the `room_version` property of the error response for the room's version.
		case incompatibleRoomVersion = "M_INCOMPATIBLE_ROOM_VERSION"

		/// The state change requested cannot be performed, such as attempting to unban a user who is not banned.
		case badState = "M_BAD_STATE"

		/// The room or resource does not permit guests to access it.
		case guestAccessForbidden = "M_GUEST_ACCESS_FORBIDDEN"

		/// A Captcha is required to complete the request.
		case captchaNeeded = "M_CAPTCHA_NEEDED"

		/// The Captcha provided did not match what was expected.
		case captchaInvalid = "M_CAPTCHA_INVALID"

		/// A required parameter was missing from the request.
		case missingParameter = "M_MISSING_PARAM"

		/// A parameter that was specified has the wrong value.
		/// For example, the server expected an integer and instead received a string.
		case invalidParameter =  "M_INVALID_PARAM"

		/// The request or entity was too large.
		case tooLarge = "M_TOO_LARGE"

		/// The resource being requested is reserved by an application service, or the application service making the request has not created the resource.
		case exclusive = "M_EXCLUSIVE"

		/// The request cannot be completed because the homeserver has reached a resource limit imposed on it.
		/// - Exemple: A homeserver held in a shared hosting environment may reach a resource limit if it starts using too much memory or disk space.
		/// - important: The error MUST have an `admin_contact` field to provide the user receiving the error a place to reach out to.
		/// Typically, this error will appear on routes which attempt to modify state (eg: sending messages, account data, etc) and not routes which only read state (eg: `/sync`, get account data, etc).
		case resourceLimitExceeded = "M_RESOURCE_LIMIT_EXCEEDED"

		/// The user is unable to reject an invite to join the server notices room.
		/// - SeeAlso: The Server Notices module for more information.
		case cannotLeaveServerNoticeRoom = "M_CANNOT_LEAVE_SERVER_NOTICE_ROOM"
	}

}


// MARK: - Login

/// A home server supported login
public struct LoginFlow: ResponsesAPI {

	/// The login type.
	/// This is supplied as the `type` when logging in.
	public let type : String
}


public struct LoginResponse: ResponsesAPI {

	/// The homeserver's supported login types
	public let flows : [LoginFlow]
}


