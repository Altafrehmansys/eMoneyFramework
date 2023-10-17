//
//  WalletAPIRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//

import Foundation

enum WalletAPIRouter: RequestProtocol {
    
    case getTransactions(id: String)
    case getBankAccounts
    case getCards
    var path: String {
        switch self {
        case .getTransactions:
            return EndPoints.BillPayment.getTransactionHistory
        case.getBankAccounts:
            return EndPoints.Wallet.getBankAccounts
        case .getCards:
            return EndPoints.Wallet.getCards
        }
    }
    
    var params: [String:Any] {
        switch self {
//        case let .submitBill(data):
//            var params: [String: Any] = [:]
//            params = [
//                "accountNumber": data.accountNumber ?? "",
//                     "accountTitle": data.accountTitle ?? "",
//                     "amount": data.amountDue ?? "",
//                     "amountDue": data.amount ?? "",
//                     "providerTransactionId": data.providerTransaction ?? "",
//                     "senderMsisdn": data.senderMsisdn ?? "",
//                     "serviceId": data.serviceId ?? "",
//                     "transactionId": data.transactionId ?? "",
//                     "transactionType": "COLBILL",
//                     "transferType": "payBill",
//                     "msisdn": GlobalData.shared.msisdn ?? "",
//                     "pin": UserDefaultHelper.userLoginPin ]
//            if data.providerPin != nil {
//                //params["pin"] =  data.pin ?? ""
//                params["providerPin"] = data.providerPin
//
//            }
//            return params
        case let .getTransactions(id):
            return ["transactionNumber": id]
        case .getBankAccounts:
            return [:]
        case .getCards:
            return [:]
        }
    }
    var requestType: RequestType {
        switch self {
        case .getBankAccounts, .getCards, .getTransactions:
            return .POST
        }
    }
}
