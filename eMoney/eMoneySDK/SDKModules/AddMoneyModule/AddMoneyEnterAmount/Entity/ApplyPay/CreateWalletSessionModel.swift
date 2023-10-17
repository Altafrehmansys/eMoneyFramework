//
//  CreateWalletSessionModel.swift
//  etisalatWallet
//
//  Created by macbook on 28/04/2023.
//  Copyright © 2023 Etisalat UAE. All rights reserved.
//

import Foundation

struct CreateWalletSessionModel: Codable {
    var transaction: Transaction?

    enum CodingKeys: String, CodingKey {
        case transaction = "Transaction"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        transaction = try? values.decode(Transaction.self, forKey: .transaction)
    }
    
    struct Transaction: Codable {
        var uniqueId, responseCode, responseDescription, activityLogingSequenceNumber: String?
        var walletSessionParameters: WalletSessionParameters?

        enum CodingKeys: String, CodingKey {
            case uniqueId = "UniqueID"
            case responseCode = "ResponseCode"
            case responseDescription = "ResponseDescription"
            case activityLogingSequenceNumber = "ActivityLogingSequenceNumber"
            case walletSessionParameters = "WalletSessionParameters"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            uniqueId = try? values.decode(String.self, forKey: .uniqueId)
            responseCode = try? values.decode(String.self, forKey: .responseCode)
            responseDescription = try? values.decode(String.self, forKey: .responseDescription)
            activityLogingSequenceNumber = try? values.decode(String.self, forKey: .activityLogingSequenceNumber)
            walletSessionParameters = try? values.decode(WalletSessionParameters.self, forKey: .walletSessionParameters)
        }
    }

    struct WalletSessionParameters: Codable {
        var parameters: Parameter?

        enum CodingKeys: String, CodingKey {
            case parameters = "Parameters"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            parameters = try? values.decode(Parameter.self, forKey: .parameters)
        }
    }

    struct Parameter: Codable {
        var name, value: String?

        enum CodingKeys: String, CodingKey {
            case name = "Name"
            case value = "Value"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            name = try? values.decode(String.self, forKey: .name)
            value = try? values.decode(String.self, forKey: .value)
        }
    }
}
