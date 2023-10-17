//
//  ValidatePayBillResponse.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 20/06/2023.
//

import Foundation

class ValidatePayBillResponse: BaseResponseModel {
    let data: ValidatePayBillData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ValidatePayBillData.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}

struct ValidatePayBillData: Codable {
    let billedAmount: String?
    let transactionId: String?
    let min: String?
    let max: String?
    let denominationResponse:DemodenominationResponse?
    let additionalInfo:[AdditionalInformation]?
}
struct DemodenominationResponse:Codable {
    let denominations:[Int]?
    let min:Int?
    let max:Int?
    let multipleOf:String?
}
struct AdditionalInformation:Codable {
    let name:String?
    let value:String?
}
