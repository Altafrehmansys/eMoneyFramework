//
//  Countries.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on May 26, 2023
//
import Foundation

class Countries: Codable {

	var code: String?
    var currency: Currency?
    var products: [CountryProducts]?
    var name: String?
    var version: String?

	private enum CodingKeys: String, CodingKey {
		case code = "code"
		case currency = "currency"
		case products = "products"
		case name = "name"
		case version = "version"
	}

    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		currency = try values.decodeIfPresent(Currency.self, forKey: .currency)
		products = try values.decodeIfPresent([CountryProducts].self, forKey: .products)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		version = try values.decodeIfPresent(String.self, forKey: .version)
	}

    init() {
    }
}
