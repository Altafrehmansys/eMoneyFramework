//
//  EFRKeyAndConfig.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on April 25, 2023
//
import Foundation

class EFRKeyAndConfigResponseModel: BaseResponseModel {

	var data: EFRKeyAndConfigData?

	private enum CodingKeys: String, CodingKey {
		case data = "data"
	}

	public required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent(EFRKeyAndConfigData.self, forKey: .data)
        try super.init(from: decoder)
	}

}
