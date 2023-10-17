//
//  AddDebitCardResponseModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 19/06/2023.
//

import Foundation

final class AddDebitCardResponseModel: BaseResponseModel {
    let data: AddDebitCardResponseDataModel?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try? values.decode(AddDebitCardResponseDataModel.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    // MARK: - Data Model
    struct AddDebitCardResponseDataModel: Codable {

        let url: String?
        let transactionId: String?

        enum CodingKeys: String, CodingKey {
            case url
            case transactionId = "instrumentFri"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            url = try? values.decode(String.self, forKey: .url)
            transactionId = try? values.decode(String.self, forKey: .transactionId)
        }

    }
}
