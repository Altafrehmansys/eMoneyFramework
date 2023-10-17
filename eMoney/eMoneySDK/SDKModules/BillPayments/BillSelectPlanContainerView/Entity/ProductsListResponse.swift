//
//  ProductsListResponse.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 05/07/2023.
//

import Foundation

class ProductsListResponse: BaseResponseModel {
    
    // MARK: - Model Variables
    let data: ProductsListData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ProductsListData.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}

struct ProductsListData: Codable {
    let logoUrl: String
    let providerStatus: Bool?
    let productList: [Product]
}

struct Product: Codable {
    let displayText: String?
    let skuCode: String?
    let benefits: [String]?
    let minAmount: Double?
    let receiveAmount: String?
    let transferType: String
    let sendAmount: String?
    let flowType: String?
    let maxAmount: Double?
    let receiveCurrencyIso: String?
    let sendCurrencyIso: String?
}
