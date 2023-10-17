//
//  CountryListResponseModel.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on May 26, 2023
//
import Foundation

class CountryListResponseModel: BaseResponseModel {

	let data: CountryListData?

	private enum CodingKeys: String, CodingKey {
		case data = "data"
	}

    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent(CountryListData.self, forKey: .data)
        try super.init(from: decoder)
	}

}
