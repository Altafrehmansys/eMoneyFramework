//
//  ReEnterYourPINResponseModel.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation

struct ReEnterYourPINRequestModel:Codable {
    var currentPin:String?
    var pin:String?
    var newPin:String?
    var repeatNewPin:String?
}

class ReEnterYourPINResponseModel:BaseResponseModel{
    var data : PinData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(PinData.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class PinData:Codable{
   
}
