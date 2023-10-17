//
//  ParkingSMSCopyResponseModel.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation

class ParkingZoneResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    var data:ParkingSMSModel?
    
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ParkingSMSModel.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class ParkingSMSCopyResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    var data:ParkingSMSModel?
    
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ParkingSMSModel.self, forKey: .data)
        try super.init(from: decoder)
    }
}
class ParkingSMSModel:Codable {
    // MARK: - Model Variables
    var shortCode: String?
    var messageText: String?
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case shortCode
        case messageText
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        shortCode = try values.decodeIfPresent(String.self, forKey: .shortCode)
        messageText = try values.decodeIfPresent(String.self
                                                 , forKey: .messageText)
    }
}
