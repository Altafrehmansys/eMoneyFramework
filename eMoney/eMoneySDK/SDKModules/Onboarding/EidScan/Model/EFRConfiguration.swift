//
//  Configuration.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on April 25, 2023
//
import Foundation

class EFRConfiguration: Codable {

	var ackMessage: String?
	var data: String?

	private enum CodingKeys: String, CodingKey {
		case ackMessage = "AckMessage"
		case data = "data"
	}

    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        ackMessage = try values.decodeIfPresent(String.self, forKey: .ackMessage)
		data = try values.decodeIfPresent(String.self, forKey: .data)
	}

}
