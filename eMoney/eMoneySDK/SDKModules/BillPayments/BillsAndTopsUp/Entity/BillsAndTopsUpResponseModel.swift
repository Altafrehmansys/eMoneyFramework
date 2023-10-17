//
//  BillsAndTopsUpResponseModel.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation

class BillsAndTopsUpResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    
    let data : [ListItems]?
  
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ListItems].self, forKey: .data)
        try super.init(from: decoder)
    }
}

struct ListItems : Codable {
    let codeId : String?
    let codeTypeId : String?
    var title : String?
    let orderNumber : String?
    let imageUrl:String?
    let parentCodeId : String?
    let serviceId: String?
    let listItems : [ListItems]?
    let resourceConfig:ResourceConfig?
    
    var isParent:Bool {
        return self.parentCodeId == nil || self.parentCodeId?.isEmpty == true
    }
    var type:BillsAnsTopUpType {
        return BillsAnsTopUpType(rawValue: /self.codeId) ?? .none
    }
    enum CodingKeys: String, CodingKey {

        case codeId = "codeId"
        case codeTypeId = "codeTypeId"
        case title = "title"
        case orderNumber = "orderNumber"
        case imageUrl = "imageUrl"
        case listItems = "listItems"
        case parentCodeId = "parentCodeId"
        case serviceId = "serviceId"
        case resourceConfig = "resourceConfig"
    }

//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        codeId = try values.decodeIfPresent(String.self, forKey: .codeId)
//        codeTypeId = try values.decodeIfPresent(String.self, forKey: .codeTypeId)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        orderNumber = try values.decodeIfPresent(String.self, forKey: .orderNumber)
//        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
//        parentCodeId = try values.decodeIfPresent(String.self, forKey: .parentCodeId)
//        serviceId = try values.decodeIfPresent(String.self, forKey: .serviceId)
//        listItems = try values.decodeIfPresent([ListItems].self, forKey: .listItems)
//        
//    }

}
// MARK: - ResourceConfig
struct ResourceConfig: Codable {
    var fields: [Field]?
    var originalFees:String?
    var dropDownOptions:[ResourceDropDownOption]?
    var dropDownLabel, minimumDigitLimit, inputType, transactionLabel: String?
    var maximumDigitLimit: String?
    var displayConfirmationScreen: Bool?
    var webUrl:String?
}
// MARK: - ResourceDropDownOption
struct ResourceDropDownOption: Codable {
    var title, sortOrder, value: String?
}
// MARK: - Field
struct Field: Codable {
    var minAmount: String?
    var payAmountChange, denominationList, partialPayment: Bool?
    var maxAmount, type: String?
    var negativePayment: Bool?
    var fixPayments:[FixPayment]?

    enum CodingKeys: String, CodingKey {
        case minAmount = "min_amount"
        case payAmountChange = "pay_amount_change"
        case denominationList = "denomination_list"
        case partialPayment = "partial_payment"
        case maxAmount = "max_amount"
        case type
        case negativePayment = "negative_payment"
        case fixPayments = "fix_payment"
    }
}
// MARK: - FixPayment
struct FixPayment: Codable {
    var withoutSocial, social, fixedAmount: String?

    enum CodingKeys: String, CodingKey {
        case withoutSocial = "without_social"
        case social
        case fixedAmount = "fixed_amount"
    }
}
