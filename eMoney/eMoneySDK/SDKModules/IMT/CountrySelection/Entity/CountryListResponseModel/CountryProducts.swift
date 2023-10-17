//
//  CountryProducts.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on May 26, 2023
//
import Foundation

class CountryProducts: Codable {

	let localCurrency: Currency?
	let country: Country?
	let id: String?
	let receiveCurrency: [Currency]?
	let deliveryOptionName: String?
	let imageUrl: String?
	let deliveryOptionList: [DeliveryOptionList]?
	let deliveryOptionListLabel: String?
	let deliveryOption: String?
	let baseCurrency: Currency?

	private enum CodingKeys: String, CodingKey {
		case localCurrency = "localCurrency"
		case country = "country"
		case id = "id"
		case receiveCurrency = "receiveCurrency"
		case deliveryOptionName = "deliveryOptionName"
		case imageUrl = "imageUrl"
		case deliveryOptionList = "deliveryOptionList"
		case deliveryOptionListLabel = "deliveryOptionListLabel"
		case deliveryOption = "deliveryOption"
		case baseCurrency = "baseCurrency"
	}

	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		localCurrency = try values.decodeIfPresent(Currency.self, forKey: .localCurrency)
		country = try values.decodeIfPresent(Country.self, forKey: .country)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		receiveCurrency = try values.decodeIfPresent([Currency].self, forKey: .receiveCurrency)
		deliveryOptionName = try values.decodeIfPresent(String.self, forKey: .deliveryOptionName)
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
		deliveryOptionList = try values.decodeIfPresent([DeliveryOptionList].self, forKey: .deliveryOptionList)
		deliveryOptionListLabel = try values.decodeIfPresent(String.self, forKey: .deliveryOptionListLabel)
		deliveryOption = try values.decodeIfPresent(String.self, forKey: .deliveryOption)
		baseCurrency = try values.decodeIfPresent(Currency.self, forKey: .baseCurrency)
	}

}
