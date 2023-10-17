//
//  Country.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on May 26, 2023
//
import Foundation

class Country: Codable {

	let name: String?
	let code: String?

	private enum CodingKeys: String, CodingKey {
		case name = "name"
		case code = "code"
	}

    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		code = try values.decodeIfPresent(String.self, forKey: .code)
	}

}
