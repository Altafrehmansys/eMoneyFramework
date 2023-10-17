//
//  BillPaymentSuccessResponseModel.swift
//  e&money
//
//  Created by Usama Zahid Khan on 05/06/2023.
//  
//

import Foundation

class BillPaymentSuccessResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    let data: BillPaymentSuccessResponseData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(BillPaymentSuccessResponseData.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}

struct BillPaymentSuccessResponseData: Codable {
    let toTransaction: String?
    let paymentType: String?
    let title: String?
    let amount: String?
    let status: String?
    let enableResend: Bool?
    let externalTransactionId: String?
    let listType: String?
    let transactionNumber: String?
    let transactionId:String?
    let date:String?
    let listTypeTitle: String?
    let fee: String?
    let toDisplay: String?
    let isCharity: Bool?
    let currency: String?
    var amountWithCurrency:String {
        return "\(self.currency ?? "") \(self.amount ?? "0.00")"
    }
    var feeWithCurrency:String {
        return "\(self.currency ?? "") \(self.fee ?? "0.00")"
    }
    var formattedDate:String {
        return "\(self.date?.format(to: "MMM dd, yyyy") ?? "-") at \(self.date?.format(to: "hh:mm a") ?? "-")"
    }
}
