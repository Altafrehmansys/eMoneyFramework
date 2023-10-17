//
//  CheckAppVersionResponse.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 08/03/2023.
//

import Foundation

class CheckAppVersionResponseModel:BaseResponseModel{
    var data : CheckAppVersionData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(CheckAppVersionData.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class CheckAppVersionData:Codable{
    var appTimeOut : String?
    var result : String?
    var languageVersion : String?

    enum CodingKeys: String, CodingKey {
        case appTimeOut = "appTimeOut"
        case result = "result"
        case languageVersion = "languageVersion"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        appTimeOut = try values.decodeIfPresent(String.self, forKey: .appTimeOut)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        languageVersion = try values.decodeIfPresent(String.self, forKey: .languageVersion)
    }
}
