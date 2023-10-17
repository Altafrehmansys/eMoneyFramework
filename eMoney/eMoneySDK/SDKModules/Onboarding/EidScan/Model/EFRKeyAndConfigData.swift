//
//  Data.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on April 25, 2023
//
import Foundation

class EFRKeyAndConfigData: Codable {

	var configuration: EFRConfiguration?
	var temporaryKey: EFRTemporaryKey?

	private enum CodingKeys: String, CodingKey {
		case configuration = "configuration"
		case temporaryKey = "temporaryKey"
	}

    public required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		configuration = try values.decodeIfPresent(EFRConfiguration.self, forKey: .configuration)
		temporaryKey = try values.decodeIfPresent(EFRTemporaryKey.self, forKey: .temporaryKey)
	}

}
