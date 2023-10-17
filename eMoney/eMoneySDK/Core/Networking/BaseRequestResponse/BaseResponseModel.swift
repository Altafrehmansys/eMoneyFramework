//
//  BaseResponseModel.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 08/03/2023.
//

import Foundation

class BaseResponseModel:Codable{
    
    var displayAppRating : Bool?
    var responseCode : String?
    var responseMessage : String?
    var title : String?
    private enum CodingKeys: String, CodingKey {
        case displayAppRating = "displayAppRating"
        case responseCode = "responseCode"
        case responseMessage = "responseMessage"
        case title = "title"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        displayAppRating = try values.decodeIfPresent(Bool.self, forKey: .displayAppRating)
        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

