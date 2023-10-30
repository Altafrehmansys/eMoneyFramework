//
//  EndPoints.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 07/03/2023.
//

import Foundation

enum EndPoints {
    static var route: String {
        return "v1/"
//        return "v2-pd/"
//        switch Environment.name {
//        case .UAT:
//            return "v2/"
//        case .PreProduction:
//            return "v2-pd/"
//        default:
//            return ""
//        }
    }
    
    enum Language{
        static let languagePack             = "\(route)language/pack"
        static let allLanguages             = "\(route)language/all"
    }
    
    enum Onboarding {
        static let checkAppVersion          = "\(route)app/check-app-version"
        static let walkthrough              = "\(route)app/screen-messages"
//        static let registerationStatus      = "\(route)registration/status"
        static let registerationStatus      = "registration/\(route)status"
        
//    https://enmoneyapim.azure-api.net/registration/v1/status
        
        static let otpSend                  = "otp/\(route)send"
        static let forgetPin                  = "registrations/\(route)generateOtpForCredentials"
        static let tokenGetter              = "gettoken/\(route)token"
//        static let otpSend                  = "\(route)registration/otp/send"
//        static let otpVerify                = "\(route)registration/otp/verify"
        static let otpVerify                = "otp/\(route)verify"
//    https://enmoneyapim.azure-api.net/otp/v1/verify
        
        
        static let login                    = "login/\(route)login"
//        static let ocrAnalyze               = "registration/ocr/analyze"
        static let ocrAnalyze               = "profile/\(route)ocr/analyze"
//    https://enmoneyapim.azure-api.net/profile/v1/ocr/analyze
        static let updateDocument           = "profile/updateDocument"
//        static let keyAndConfiguration      = "registration/get-temporary-key-and-cofiguration"
        static let keyAndConfiguration      = "profile/\(route)get-temporary-key-and-cofiguration"
//    https://enmoneyapim.azure-api.net/profile/v1/get-temporary-key-and-cofiguration
//    https://enmoneyapim.azure-api.net/profile/v1/liveness
        static let liveness                 = "profile/\(route)liveness"
//        static let liveness                 = "registration/liveness"
//        static let rhserv                   = "registration/rh-serv"
        static let rhserv                   = "profile/\(route)rh-serv"
//    https://enmoneyapim.azure-api.net/profile/v1/rh-serv
        static let termsAndCondition        = "content/html"
//    https://enmoneyapim.azure-api.net/onboarding/v1/register
        static let register                 = "onboarding/\(route)register"
//        static let register                 = "\(route)registration/register"
        static let initiatePin              = "\(route)registration/generateOtpForCredentials"
        static let resetPin                 = "\(route)registration/user/resetPinWithOtp"
        static let lookup                   = "\(route)registration/lookup"
//    https://enmoneyapim.azure-api.net/onboarding/v1/validate-email
        static let verifyEmail              = "onboarding/\(route)validate-email"
        static let cardColor                = "\(route)registration/card-color"
    }
    
    enum AddMoney {
        static let getOptionsList           = "\(route)add-money/app-resources"
        static let getBankAccountsList      = "\(route)add-money/get-bank-accounts"
        static let getBanksList             = "\(route)add-money/get-banks"
        static let getLocationsList         = "\(route)add-money/location-locator"
        static let getLeanCustomer          = "\(route)add-money/get-lean-customer"
        static let createPaymentIntent      = "\(route)add-money/create-payment-intent"
        static let verifyIban               = "\(route)add-money/verify-iban/"
        static let removeBankAccount        = "\(route)add-money/delete-payment-source"
        static let epgInitialize            = "\(route)add-money/epg/initialize"
//        static let initializeAddCard        = "\(route)add-money/debit-cards/initialize-add-card"
        
        static let initializeAddCard        = "addmoney/\(route)debit-cards/initialize-add-card"
        static let getAvailableBalance = "addmoney/\(route)user-account/available-balance"
        static let initializeCardPayment    = "addmoney/\(route)debit-cards/initialize-card-payment"
        static let finalizeCardPayment      = "\(route)add-money/debit-cards/finalize-card-payment"
        static let finalizeApplePayPayment  = "\(route)add-money/debit-cards/finalize-apple-pay-payment"
        static let listCards                = "addmoney/\(route)debit-cards/list-cards"
//    https://enmoneyapim.azure-api.net/addmoney/v1/debit-cards/list-cards
        static let denominationsList        = "\(route)add-money/denominations"
//        static let removeCard               = "\(route)add-money/debit-cards/remove-card"
        static let removeCard               = "addmoney/\(route)debit-cards/remove-card"
//    https://enmoneyapim.azure-api.net/addmoney/v1/debit-cards/remove-card
        static let updateIntentStatus       = "\(route)add-money/update-intent-status"
//        static let addMoneyMetaData         = "\(route)add-money/meta-data"
        static let addMoneyMetaData         = "addmoney/\(route)meta-data"
//    https://enmoneyapim.azure-api.net/addmoney/v1/meta-data
    }

    enum BillPayment{
        
        static let getBillTypes = "\(route)bill/bill-payment-types"
        static let savedBills = ""
        static let getSMSDetails = "mparking/get-mparking-details-message"
        static let resourceList = "resources/list"
        static let resourceLookups = "resources/lookup"
        static let submitBill = "paybill/agent/submit"
        static let getTransactionHistory = "transaction-history/get-transaction-history-detail"
        static let getProducts = "ding/get-products"
        static let submitMobileInternational = "topup/agent/submit"
        static let mParkingZones = "\(route)bill/mparking/region-zone-details"
        static let payBill = "user-account/id/validate/paybill"
        static let addBeneficiary = "\(route)bill/beneficiary/add"
        static let recentParkings = "\(route)bill/mparking/recent-parking/get-all"
        static let addRecentParkings = "\(route)bill/mparking/recent-parking/add"
        static let getBills = "\(route)bill/beneficiary/get-all-by-bill-type"
    }
    
    enum IMT {
        static let getCountries             = "money-transfer-hub/operations"
    }
    
    enum Home {
        static let getAvailableBalance = "addmoney/\(route)user-account/available-balance"
//        static let getAvailableBalance = "\(route)add-money/user-account/available-balance"
//    https://enmoneyapim.azure-api.net/addmoney/v1/user-account/available-balance
    }
    
    enum Common {
        static let getCountries = "ding/get-countries"
        static let getNetworkProviders = "ding/get-providers"
        static let validatePhoneNumber = "user-account/id/validate/paybill"
    }
    enum Wallet {
        static let getTransactions = "mwallet-rest/api/transaction-history/get-transaction-history"
        static let getBankAccounts = "\(route)add-money/get-bank-accounts"
        static let getCards = "debit-cards/list-cards"
    }
    
    enum Profile {
        static let changePin = "changepin/\(route)change-pin"
    }
}

