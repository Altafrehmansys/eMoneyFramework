//
//  Data.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on May 26, 2023
//
import Foundation

class CountryListData: Codable {

	let countries: [Countries]?
	let topCorridors: [Countries]?

	private enum CodingKeys: String, CodingKey {
		case countries = "countries"
		case topCorridors = "topCorridors"
	}

    public required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		countries = try values.decodeIfPresent([Countries].self, forKey: .countries)
		topCorridors = try values.decodeIfPresent([Countries].self, forKey: .topCorridors)
	}

}
