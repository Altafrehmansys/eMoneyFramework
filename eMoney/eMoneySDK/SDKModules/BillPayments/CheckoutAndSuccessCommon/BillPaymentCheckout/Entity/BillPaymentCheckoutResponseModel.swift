//
//  BillPaymentCheckoutResponseModel.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import Foundation

class BillPaymentCheckoutResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    let data: BillPaymentCheckoutResponseData?
    let survey:CheckoutSurvey?
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case survey,responseMessage,displayAppRating
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(BillPaymentCheckoutResponseData.self, forKey: .data)
        survey = try values.decodeIfPresent(CheckoutSurvey.self, forKey: .survey)
        try super.init(from: decoder)
    }
    
}

struct BillPaymentCheckoutResponseData: Codable {
    let transactionId: String?
}
    
// MARK: - CheckoutSurvey
struct CheckoutSurvey: Codable {
    var transactionTypeGUID: String?
    var isBottomSheet: Bool?
    var collectionPointGUID: String?
    var questions: [SurveyQuestion]?

    enum CodingKeys: String, CodingKey {
        case transactionTypeGUID = "transactionTypeGuid"
        case isBottomSheet
        case collectionPointGUID = "collectionPointGuid"
        case questions
    }
}

// MARK: - Question
struct SurveyQuestion: Codable {
    var questionID: String?
    var isOptional: Bool?
    var rightLabel, question, leftLabel: String?
    var isPoor: Bool?
    var options: [String]?

    enum CodingKeys: String, CodingKey {
        case questionID = "questionId"
        case isOptional, rightLabel, question, leftLabel, isPoor, options
    }
}
