//
//  Responses.swift.swift
//  MatrixClient
//
//  Created by Marcus Florentin on 12/05/2020.
//

import Foundation


// MARK: - Responses


protocol ResponsesAPI: Codable { }


// MARK: - Error Responses


/// Any errors which occur at the Matrix API level MUST return a "standard error response".
///
/// The `error` string will be a human-readable error message, usually a sentence explaining what went wrong. The `errcode` string will be a unique string which can be used to handle an error message e.g. `M_FORBIDDEN`. These error codes should have their namespace first in ALL CAPS, followed by a single "__" to ease separating the namespace from the error code. For example, if there was a custom namespace `com.mydomain.here`, and a `FORBIDDEN` code, the error code should look like `COM.MYDOMAIN.HERE_FORBIDDEN`. There may be additional keys depending on the error, but the keys `error` and `errcode` MUST always be present.
/// - note: Errors are generally best expressed by their error code rather than the HTTP status code returned. When encountering the error code `M_UNKNOWN`, clients should prefer the HTTP status code as a more reliable reference for what the issue was. For example, if the client receives an error code of `M_NOT_FOUND` but the request gave a 400 Bad Request status code, the client should treat the error as if the resource was not found. However, if the client were to receive an error code of `M_UNKNOWN` with a 400 Bad Request, the client should assume that the request being made was invalid.
public struct StandardError: ResponsesAPI {

	public let errcode : String

	public let error : String

}



