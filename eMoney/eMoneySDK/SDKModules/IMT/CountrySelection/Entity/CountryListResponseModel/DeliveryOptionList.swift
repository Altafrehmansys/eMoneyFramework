//
//  DeliveryOptionList.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on May 26, 2023
//
import Foundation

class DeliveryOptionList: Codable {

	let id: String?
	let name: String?

	private enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
	}

    public required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}

}
