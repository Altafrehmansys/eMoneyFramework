//
//  AddMoneyMetaDataResponseModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 11/07/2023.
//

import Foundation


final class AddMoneyMetaDataResponseModel: BaseResponseModel {
    
    let data: AddMoneyMetaDataResponseDataModel?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try? values.decode(AddMoneyMetaDataResponseDataModel.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    // MARK: - Data Model
    struct AddMoneyMetaDataResponseDataModel: Codable {
        let appResourceResponses: [AddMoneyOptionsListDataModel]?
        let denominations: DenominationsDataModel?
        let leanCustomerData: LeanCustomerDataModel?
        let banksData: BanksModel?
        
        enum CodingKeys: String, CodingKey {
            case appResourceResponses
            case denominations
            case leanCustomerData
            case banksData = "bankData"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            appResourceResponses = try? values.decode([AddMoneyOptionsListDataModel].self, forKey: .appResourceResponses)
            denominations = try? values.decode(DenominationsDataModel.self, forKey: .denominations)
            leanCustomerData = try? values.decode(LeanCustomerDataModel.self, forKey: .leanCustomerData)
            banksData = try? values.decode(BanksModel.self, forKey: .banksData)
        }
    }
    
    struct AddMoneyOptionsListDataModel: Codable {

        let subResources: [AddMoneyOptionsListOptionModel]?
        let languageCode: String?
        let title: String?
        let identifier: String?
        let osType: String?
        let description: String?
        let iconImageUrl: String?

        enum CodingKeys: String, CodingKey {
            case subResources = "subResources"
            case languageCode = "languageCode"
            case title = "title"
            case identifier = "identifier"
            case osType = "osType"
            case description = "description"
            case iconImageUrl = "iconImageUrl"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            subResources = try? values.decode([AddMoneyOptionsListOptionModel].self, forKey: .subResources)
            languageCode = try? values.decode(String.self, forKey: .languageCode)
            title = try? values.decode(String.self, forKey: .title)
            identifier = try? values.decode(String.self, forKey: .identifier)
            osType = try? values.decode(String.self, forKey: .osType)
            description = try? values.decode(String.self, forKey: .description)
            iconImageUrl = try? values.decode(String.self, forKey: .iconImageUrl)
        }
    }

    struct AddMoneyOptionsListOptionModel: Codable {

        let languageCode: String
        let title: String
        let identifier: String
        let description: String
        let iconImageUrl: String

        enum CodingKeys: String, CodingKey {
            case languageCode = "languageCode"
            case title = "title"
            case identifier = "identifier"
            case description = "description"
            case iconImageUrl = "iconImageUrl"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            languageCode = try values.decode(String.self, forKey: .languageCode)
            title = try values.decode(String.self, forKey: .title)
            identifier = try values.decode(String.self, forKey: .identifier)
            description = try values.decode(String.self, forKey: .description)
            iconImageUrl = try values.decode(String.self, forKey: .iconImageUrl)
        }
    }
    
    struct DenominationsDataModel: Codable {
        var denominations: [Int]?
        var min: Double?
        var max: Double?
        var addMoneyAmountRequireOtp: Double?
        var fee: String?
        var multipleOf: String?
        var vat: String?
        var defaultAmount: String?
        
        enum CodingKeys: String, CodingKey {
            case denominations
            case min
            case max
            case addMoneyAmountRequireOtp
            case fee
            case multipleOf
            case vat
            case defaultAmount
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            denominations = try values.decodeIfPresent([Int].self, forKey: .denominations)
            min = try values.decodeIfPresent(Double.self, forKey: .min)
            max = try values.decodeIfPresent(Double.self, forKey: .max)
            addMoneyAmountRequireOtp = try values.decodeIfPresent(Double.self, forKey: .addMoneyAmountRequireOtp)
            fee = try values.decodeIfPresent(String.self, forKey: .fee)
            multipleOf = try values.decodeIfPresent(String.self, forKey: .multipleOf)
            vat = try values.decodeIfPresent(String.self, forKey: .vat)
            defaultAmount = try values.decodeIfPresent(String.self, forKey: .defaultAmount)
        }
    }
    
    struct LeanCustomerDataModel: Codable {
        
        var customerID: String?
        var destinationID: String?
        
        enum CodingKeys: String, CodingKey {
            case customerID = "leanCustomerId"
            case destinationID = "paymentDestinationId"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            customerID = try? values.decodeIfPresent(String.self, forKey: .customerID)
            destinationID = try? values.decodeIfPresent(String.self, forKey: .destinationID)
        }
    }
    
    
    struct BanksModel: Codable {

        let banksList: [BankDataModel]?
        let popularBanks: [BankDataModel]?

        private enum CodingKeys: String, CodingKey {
            case banksList = "banks"
            case popularBanks = "popularBanks"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            banksList = try? values.decodeIfPresent([BankDataModel].self, forKey: .banksList)
            popularBanks = try? values.decodeIfPresent([BankDataModel].self, forKey: .popularBanks)
        }
    }
    
    struct BankDataModel: Codable {
        
        let bankName : String?
        let bankLogo : String?
        let bankIdentifier : String?
        let type : String?
        let bankLogoAlt : String?
        let active: Bool?
        let minLimit: Int?
        let maxLimit: Int?
        let enabledForPayment: Bool?
        let enabledForData: Bool?
        let availableForPayment: Bool?
        let availableForData: Bool?
        
        
        enum CodingKeys: String, CodingKey {
            case bankName = "bankName"
            case bankLogo = "bankLogo"
            case bankIdentifier = "bankIdentifier"
            case type = "type"
            case bankLogoAlt = "bankLogoAlt"
            case active, minLimit, maxLimit, enabledForPayment, enabledForData, availableForPayment, availableForData
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            bankName = try? values.decodeIfPresent(String.self, forKey: .bankName)
            bankLogo = try? values.decodeIfPresent(String.self, forKey: .bankLogo)
            bankIdentifier = try? values.decodeIfPresent(String.self, forKey: .bankIdentifier)
            type = try? values.decodeIfPresent(String.self, forKey: .type)
            bankLogoAlt = try? values.decodeIfPresent(String.self, forKey: .bankLogoAlt)
            active = try? values.decodeIfPresent(Bool.self, forKey: .active)
            minLimit = try? values.decodeIfPresent(Int.self, forKey: .minLimit)
            maxLimit = try? values.decodeIfPresent(Int.self, forKey: .maxLimit)
            enabledForPayment = try? values.decodeIfPresent(Bool.self, forKey: .enabledForPayment)
            enabledForData = try? values.decodeIfPresent(Bool.self, forKey: .enabledForData)
            availableForPayment = try? values.decodeIfPresent(Bool.self, forKey: .availableForPayment)
            availableForData = try? values.decodeIfPresent(Bool.self, forKey: .availableForData)
        }
    }
}
