//
//  MatrixClient.swift
//  MatrixClient
//
//  Created by Marcus Florentin on 11/05/2020.
//

import Foundation


class MatrixClient {


	/// Verison
	public struct Version: Codable {
		public let versions : Set<Endpoints.Version>

		public let unstableFeatures : [String : Bool]
	}




}
