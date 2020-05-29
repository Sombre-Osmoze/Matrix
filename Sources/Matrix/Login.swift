//
//  Login.swift
//  Matrix
//
//  Created by Marcus Florentin on 29/05/2020.
//

import Foundation

// MARK: - Login


/// A home server supported login
public struct LoginFlow: Codable {

	/// The login type.
	/// This is supplied as the `type` when logging in.
	public let type : Flow

	public enum Flow : String, Codable, CaseIterable {
		case password = "m.login.password"
	}
}

