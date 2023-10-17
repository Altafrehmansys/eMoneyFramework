//
//  Currency.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on May 26, 2023
//
import Foundation

class Currency: Codable {

	let currencyCode: String?
	let currencyName: String?
	let currencyPrecision: String?

	private enum CodingKeys: String, CodingKey {
		case currencyCode = "currencyCode"
		case currencyName = "currencyName"
		case currencyPrecision = "currencyPrecision"
	}

    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
		currencyName = try values.decodeIfPresent(String.self, forKey: .currencyName)
		currencyPrecision = try values.decodeIfPresent(String.self, forKey: .currencyPrecision)
	}

}
