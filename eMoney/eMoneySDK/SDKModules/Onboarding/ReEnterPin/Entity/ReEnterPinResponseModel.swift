//
//  ReEnterPinResponseModel.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/04/2023.
//  
//

import Foundation

class ReEnterPinResponseModel: BaseResponseModel {
    
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
