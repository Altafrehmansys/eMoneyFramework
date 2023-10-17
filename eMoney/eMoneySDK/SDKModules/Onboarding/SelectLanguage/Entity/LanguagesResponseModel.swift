//
//  LanguagesResponseModel.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 13/04/2023.
//

import Foundation

class LanguagesResponseModel: BaseResponseModel {
    
    var data: [LanguageData]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([LanguageData].self   , forKey: .data)
        try super.init(from: decoder)
    }
    
}

class LanguageData : Codable {
    let languageName : String?
    let languageCode : String?
    let languageVersion : String?
    let createdDateTime : String?
    
    var isSelected:Bool = false

    enum CodingKeys: String, CodingKey {
        case languageName = "languageName"
        case languageCode = "languageCode"
        case languageVersion = "languageVersion"
        case createdDateTime = "createdDateTime"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        languageName = try values.decodeIfPresent(String.self, forKey: .languageName)
        languageCode = try values.decodeIfPresent(String.self, forKey: .languageCode)
        languageVersion = try values.decodeIfPresent(String.self, forKey: .languageVersion)
        createdDateTime = try values.decodeIfPresent(String.self, forKey: .createdDateTime)
    }

}

