//
//  RegistrationLivenessResponse.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 27/04/2023.
//

import Foundation

class RegistrationLivenessResponse: BaseResponseModel{
    var data : RegistrationLivenessData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(RegistrationLivenessData.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class RegistrationLivenessData: Codable {

    var data: RegistrationLivenessDataCommand?
    var command: String?

    private enum CodingKeys: String, CodingKey {
        case data = "data"
        case command = "command"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(RegistrationLivenessDataCommand.self, forKey: .data)
        command = try values.decodeIfPresent(String.self, forKey: .command)
    }

}

class RegistrationLivenessDataCommand: Codable {

    var command: String?

    private enum CodingKeys: String, CodingKey {
        case command = "command"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        command = try values.decodeIfPresent(String.self, forKey: .command)
    }

}
