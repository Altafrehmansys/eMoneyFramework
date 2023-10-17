//
//  FundInResponseModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/06/2023.
//

import Foundation

struct FundInResponseModel: Codable {
    let paymentTransactionID: String
    let paymentTitle: String
    let paymentSubTitle: String
    let paymentBANKNAME: String
    let paymentIBAN: String
    let paymentACCOUNTNAME: String
    let paymentAMOUNT: String
    let paymentBALANCE: String
    let paymentDATETIME: String
    let paymentStatus: String

    enum CodingKeys: String, CodingKey {
        case paymentTransactionID = "paymentTransactionId"
        case paymentTitle,
             paymentSubTitle,
             paymentBANKNAME,
             paymentIBAN,
             paymentACCOUNTNAME,
             paymentAMOUNT,
             paymentBALANCE,
             paymentDATETIME,
             paymentStatus
    }
}
