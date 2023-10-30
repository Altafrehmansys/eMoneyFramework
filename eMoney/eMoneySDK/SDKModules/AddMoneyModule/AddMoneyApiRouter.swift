//
//  AddMoneyApiRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 17/05/2023.
//

import Foundation

enum AddMoneyApiRouter: RequestProtocol {
    case getOptionsList(typeIdentifier: String)
    case getBankAccountsList
    case getBanksList
    case createPaymentIntent(param: PaymentIntentRequestModel)
    case verify(iban: String)
    case getLocationsList(param: GetLocationListModel)
    case removeBankAccount(sourceId: String)
    case paymentGateway(param: UaePgsRequestModel)
    case initializeAddCard
    case initializeCardPayment(param: InitializeCardPaymentRequestModel)
    case finalizeCardPayment(param: FinalizeCardPaymentRequestModel)
    case finalizeApplePayPayment(param: FinalizeCardPaymentRequestModel)
    case listCards(param: WalletRegistrationRequestModel)
    case removeCard(param: InitializeCardPaymentRequestModel)
    case updateIntentStatus(paymentIntentID: String)
    case addMoneyMetaData
    case availableBalance
    
    var path: String {
        switch self {
        case .getOptionsList:
            return EndPoints.AddMoney.getOptionsList
        case .getBankAccountsList:
            return EndPoints.AddMoney.getBankAccountsList
        case .verify:
            return EndPoints.AddMoney.verifyIban
        case .createPaymentIntent:
            return EndPoints.AddMoney.createPaymentIntent
        case .getLocationsList:
            return EndPoints.AddMoney.getLocationsList
        case .getBanksList:
            return EndPoints.AddMoney.getBanksList
        case .removeBankAccount:
            return EndPoints.AddMoney.removeBankAccount
        case .paymentGateway:
            return EndPoints.AddMoney.epgInitialize
        case .initializeAddCard:
            return EndPoints.AddMoney.initializeAddCard
        case .initializeCardPayment:
            return EndPoints.AddMoney.initializeCardPayment
        case .finalizeCardPayment:
            return EndPoints.AddMoney.finalizeCardPayment
        case .finalizeApplePayPayment:
            return EndPoints.AddMoney.finalizeApplePayPayment
        case .listCards:
            return EndPoints.AddMoney.listCards
        case .removeCard:
            return EndPoints.AddMoney.removeCard
        case .updateIntentStatus:
            return EndPoints.AddMoney.updateIntentStatus
        case .addMoneyMetaData:
            return EndPoints.AddMoney.addMoneyMetaData
        case .availableBalance:
            return EndPoints.AddMoney.getAvailableBalance
        }
    }
    
    var params: [String:Any] {
        switch self {
        case .getOptionsList(let identifier):
            return ["resourceCategoryCode": identifier]
            
        case .addMoneyMetaData:
            return ["resourceCategoryCode": "ADD_MONEY"]
        
        case .getBankAccountsList:
            return ["resourceCategoryCode": "ADD_MONEY"]
            
        case .verify(let iban):
            return ["iban": iban]
            
        case .createPaymentIntent(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
            
        case .getBanksList:
            return [:]
            
        case .getLocationsList(let param):
            return CommonMethods.codableToDictionary(codableObject: param)

        case .removeBankAccount(let sourceId):
            return ["paymentSourceId" : sourceId]
            
        case .paymentGateway(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
            
        case .initializeAddCard:
            return ["pin": UserDefaultHelper.userLoginPin ?? ""]
            
        case .initializeCardPayment(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
            
        case .finalizeCardPayment(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
            
        case .finalizeApplePayPayment(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
            
        case .listCards(let param):
            return CommonMethods.codableToDictionary(codableObject: param)

        case .removeCard(let params):
            return CommonMethods.codableToDictionary(codableObject: params)
            
        case .updateIntentStatus(let paymentIntentID):
            return ["paymentIntentID" : paymentIntentID]
        case .availableBalance:
            return [:]
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .getOptionsList, .getBankAccountsList, .verify, .createPaymentIntent, .getLocationsList, .getBanksList, .removeBankAccount, .paymentGateway, .initializeCardPayment, .finalizeCardPayment, .listCards, .initializeAddCard, .removeCard, .updateIntentStatus, .addMoneyMetaData, .finalizeApplePayPayment, .availableBalance:
            return .POST
        }
    }
}
