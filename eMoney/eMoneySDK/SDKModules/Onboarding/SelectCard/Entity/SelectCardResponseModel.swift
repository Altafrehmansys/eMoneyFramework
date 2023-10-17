//
//  SelectCardResponseModel.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 26/04/2023.
//  
//

import Foundation

enum SelectCardColor: String {
    case Red = "RED"
    case Gray = "GRAY"
    case Brown = "BROWN"
}

struct SelectCardRequestModel:Codable{
    var identity:String?
    var cardColor:String?
    var cardType:String?

}


class SelectCardResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    
    var value1: String?
    var value2: String?
    
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case value1
        case value2
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value1 = try values.decodeIfPresent(String.self, forKey: .value1)
        value2 = try values.decodeIfPresent(String.self, forKey: .value2)
        try super.init(from: decoder)
    }
}
