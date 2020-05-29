//
//  Identifier.swift
//  Matrix
//
//  Created by Marcus Florentin on 29/05/2020.
//

import Foundation

// MARK: - Identifers

/// This specification defines the following identifier types.
public enum IdentifierType : String, Codable, CaseIterable {

	/// The user is identified by their Matrix ID.
	case user = "m.id.user"

	/// The user is identified by a third-party identifier in canonicalised form.
	case thirdparty = "m.id.thirdparty"

	/// The user is identified by a phone number.
	case phone = "m.id.phone"
}

/// Some authentication mechanisms use a user identifier object to identify a user.
/// The user identifier object has a `type` field to indicate the type of identifier being used,
/// and depending on the type,
/// has other fields giving the information required to identify the user as described below.
public protocol Identifier : Codable {

	var type : IdentifierType { get }

}

// MARK: User Identifier

/// A client can identify a user using their Matrix ID.
/// This can either be the fully qualified Matrix user ID, or just the localpart of the user ID.
public struct UserIdentifier: Identifier {

	public let type: IdentifierType

	/// user_id or user localpart.
	public let user: MatrixID

}


// MARK: Third Party Identifier

/// A client can identify a user using a 3PID associated with the user's account on the homeserver, where the 3PID was previously associated using the **/account/3pid** API.
/// See the [3PID Types](https://matrix.org/docs/spec/appendices.html#pid-types) Appendix for a list of Third-party ID media.
public struct ThirdPartyIdentifier: Identifier {

	public let type: IdentifierType

	/// The medium of the third party identifier.
	public let medium: Medium

	/// Third Party Identifiers (3PIDs) represent identifiers on other namespaces that might be associated with a particular person.
	/// They comprise a tuple of `medium` which is a string that identifies the namespace in which the identifier exists, and an `address`: a string representing the identifier in that namespace.
	/// This must be a canonical form of the identifier, *i.e*. if multiple strings could represent the same identifier, only one of these strings must be used in a 3PID address, in a well-defined manner.
	///
	/// - Exemple: For e-mail, the `medium` is 'email' and the `address` would be the email address, *e.g.* the string `bob@example.com`. Since domain resolution is case-insensitive, the email address `bob@Example.com` is also has the 3PID address of `bob@example.com` (without the capital 'e') rather than `bob@Example.com`.
	public enum Medium: String, Codable, CaseIterable {

		/// Represents E-Mail addresses.
		/// The `address` is the raw email address in `user@domain` form with the domain in lowercase.
		/// It must not contain other text such as real name, angle brackets or a mailto: prefix.
		case email

		/// Represents telephone numbers on the public switched telephone network.
		/// The `address` is the telephone number represented as a MSISDN (Mobile Station International Subscriber Directory Number) as defined by the E.164 numbering plan.
		/// Note that MSISDNs do not include a leading '+'.
		case msisdn
	}

	/// The canonicalised third party address of the user.
	public let address: String

}

// MARK: Phone Identifier

/// A client can identify a user using a phone number associated with the user's account, where the phone number was previously associated using the **/account/3pid** API.
/// The phone number can be passed in as entered by the user; the homeserver will be responsible for canonicalising it. If the client wishes to canonicalise the phone number, then it can use the `m.id.thirdparty` identifier type with a `medium` of `msisdn` instead.
public struct PhoneIdentifier: Identifier {

	public let type: IdentifierType

	/// The country that the phone number is from
	/// - note: The `country` is the two-letter uppercase ISO-3166-1 alpha-2 country code that the number in `phone` should be parsed as if it were dialled from.
	public let country : String

	/// The phone number.
	public let phone : String

}
