//
//  UpdateProfileRequestModel.swift
//  eMoneySDK
//
//  Created by Altaf Ur Rehman on 31/10/2023.
//

import Foundation

class UpdateProfileRequest:Codable{
    
    var pin:String?
    var transactionId: String?
    var profileImage: String?
    var frontImage: String?
    var backImage: String?
    var selfieImage: String?
    var operationType: String?
    var eidNumber: String?
    var firstName:String?
    var middleName:String?
    var lastName:String?
    var expiryDate:String?
    var fullName:String?
}


class UpdateProfileResponseModel: BaseResponseModel{
    var data : UpdateProfileData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(UpdateProfileData.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class UpdateProfileData: Codable {

    var response: String?

    private enum CodingKeys: String, CodingKey {
        case response = "response"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent(String.self, forKey: .response)
    }

}
