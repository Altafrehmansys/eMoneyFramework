//
//  RegistrationResponseModel.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 02/05/2023.
//

import Foundation


class RegistrationResponseModel: BaseResponseModel{
    var data : RegistrationData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(RegistrationData.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class RegistrationData: Codable {

    var status: String?
    var username: String?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case username = "username"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        username = try values.decodeIfPresent(String.self, forKey: .username)
    }

}


class ResetPinResponseModel: BaseResponseModel{
//    var data : ResetPinData?
//
//    enum CodingKeys: String, CodingKey {
//        case data = "data"
//    }
//
//    public required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        data = try values.decodeIfPresent(ResetPinData.self, forKey: .data)
//        try super.init(from: decoder)
//    }
}

class ResetPinData: Codable {

    var status: String?
    var username: String?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case username = "username"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        username = try values.decodeIfPresent(String.self, forKey: .username)
    }

}
