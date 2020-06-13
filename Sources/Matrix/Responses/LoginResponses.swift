//
//  LoginResponses.swift
//  Matrix
//
//  Created by Marcus Florentin on 13/06/2020.
//

import Foundation


public struct LoginFlowsResponse: ResponsesAPI {

	/// The homeserver's supported login types
	public let flows : [LoginFlow]
}
