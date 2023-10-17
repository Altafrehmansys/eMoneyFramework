//
//  WalletCheckoutResponseModel.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import Foundation

class WalletCheckoutResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    let data: WalletCheckoutResponseData?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(WalletCheckoutResponseData.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}

struct WalletCheckoutResponseData: Codable {
    let transactionId: String?
}
    
