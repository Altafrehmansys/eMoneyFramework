//
//  UaePgsResponseModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 09/06/2023.
//

import Foundation

final class UaePgsResponseModel: BaseResponseModel {
    var data: UaePgsResponseDataModel?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(UaePgsResponseDataModel.self   , forKey: .data)
        try super.init(from: decoder)
    }
    
    struct UaePgsResponseDataModel: Codable {
        var uniqueId: String?
        var paymentPortalUrl: String?
        var transactionId: String?
        
        enum CodingKeys: String, CodingKey {
            case uniqueId
            case paymentPortalUrl
            case transactionId
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            uniqueId = try values.decodeIfPresent(String.self, forKey: .uniqueId)
            paymentPortalUrl = try values.decodeIfPresent(String.self, forKey: .paymentPortalUrl)
            transactionId = try values.decodeIfPresent(String.self, forKey: .transactionId)
        }
    }
}
