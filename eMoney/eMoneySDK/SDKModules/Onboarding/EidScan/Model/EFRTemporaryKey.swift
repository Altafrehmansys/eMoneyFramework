//
//  TemporaryKey.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on April 25, 2023
//
import Foundation

class EFRTemporaryKey: Codable {

	var code: String?
	var value: String?
	var ackMessage: String?
	var expiry: String?

	private enum CodingKeys: String, CodingKey {
		case code = "code"
		case value = "value"
		case ackMessage = "AckMessage"
		case expiry = "expiry"
	}

    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		value = try values.decodeIfPresent(String.self, forKey: .value)
        ackMessage = try values.decodeIfPresent(String.self, forKey: .ackMessage)
		expiry = try values.decodeIfPresent(String.self, forKey: .expiry)
	}

}
