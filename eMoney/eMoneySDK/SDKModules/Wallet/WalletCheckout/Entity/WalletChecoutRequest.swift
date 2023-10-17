//
//  BillPaymentChecoutRequest.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 26/06/2023.
//

import Foundation

struct WalletCheckoutRequest {
    
    let accountNumber: String?
    let accountTitle: String?
    let amount: String?
    let amountDue: String?
    let pin: String?
    let providerPin: String?
    let providerTransaction: String?
    let serviceId: String?
    let msisdn: String?
    let senderMsisdn: String?
    let transactionId: String?
}
