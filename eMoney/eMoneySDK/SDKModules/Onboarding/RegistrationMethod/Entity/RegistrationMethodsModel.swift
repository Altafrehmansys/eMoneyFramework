//
//  RegistrationMethodsModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import Foundation

struct  RegistrationMethodsRequestModel:Codable{
    var lookupType:String?
}

struct RegistrationMethodsModel: Codable {
    var title: String
    var subtitle: String
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case title, subtitle, image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        subtitle = try values.decode(String.self, forKey: .subtitle)
        image = try values.decode(String.self, forKey: .image)
    }
}
class LookupRegistrationMethodsModel: BaseResponseModel {
    
    var data: [LookupRegistrationData]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([LookupRegistrationData].self, forKey: .data)
        try super.init(from: decoder)
    }
    
}

class LookupRegistrationData: Codable {
    
   
        let lookupValue, imgUrl, lookupDesc, lookupCode: String?
        let lookupTitle: String?

        enum CodingKeys: String, CodingKey {
            case lookupValue
            case imgUrl
            case lookupDesc, lookupCode, lookupTitle
        }
}
