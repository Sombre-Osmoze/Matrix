//
//  Coding.swift
//  Matrix
//
//  Created by Marcus Florentin on 14/05/2020.
//

import Foundation


// MARK: - Coding

// MARK: Encoding

/// Matrix JSON object decoder.
public let encoder : JSONEncoder = .init()

// MARK: Decoding

/// Matrix JSON object encoder.
public let decoder : JSONDecoder = {
	let coder = JSONDecoder()
	coder.keyDecodingStrategy = .convertFromSnakeCase
	return coder
}()
