//
//  Enums.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 13/03/2023.
//

import Foundation

enum LanguageCode: String {
    case english = "en"
    case arabic = "ar"
}
enum LanguageFileName:String,CaseIterable{
    case english = "LangEn"
    case arabic = "LangAr"
}
enum EncryptionKey{
 static let pinKey = "v%Ww9_#|f3xAG#:-"
}



enum CustomBarButtonItemPosition: Int {
    case  right = 1
    case  left = 2
}

enum ApiResponseCode {
    static let SUCCESS = "0"
    static let SESSION_EXPIRED = "440"
    static let AML_FAILED = "50002"
}

enum RegistrationType{
    case noKyc
    case physicalKyc
}

enum UserProfile:String{
    case noKYC = "Consumer NO KYC Profile"
    case physicalKYC = "Consumer Physical KYC Profile"
    case amlUnverified = "Consumer Physical Suspended Unverified AML Profile"
}
enum UpgradeScreen: String {
    case consentScreen = "consent_screen"
    case emiratesScreen = "emirates_scan"
    case selfieScreen = "selfie_screen"
    case none
}

enum MsisdnStatus:String{
    case registered = "registered"
    case notExist = "not_exist"
    case activated = "activated"
    case pinReset = "pin_reset"
    case blocked = "blocked"
    case suspended = "suspended"
    case none = ""
}
enum UserLoginStatus:String{
    case success = "success"
    case failed = "failed"
    case locked = "locked"
    case limited = "limited"
    case blocked = "blocked"
    case suspended = "suspended"
    case none = ""
}

enum EnvoirmentName:String{
    case UAT = "UAT"
    case PreProduction = "PreProduction"
    case ProductionEnt = "ProductionEnt"
    case Production = "Production"
}

enum CashInFlowType {
    case bankAcount
    case lean
    case initializeDebitCard
    case debitCard
    case applePay
    case cashAdvance
    case none
    
    var buttonTitle: String {
        switch self {
        case .cashAdvance:
            return Strings.AddMoney.confirmButtonText
        default:
            return Strings.AddMoney.add
        }
    }
}

// PLEASE REMOVE THIS IN PRODUCTIONS
enum tempIDs:String{
    case sessionID = "sessionid=au80157ad8873bdf2348c9b931b588273f3a52"
    case accountID = "4f253453-e393-4495-bb1c-f1e3ee7628ab"
}

enum GetLocationsView:String {
    case agentsView = "AGENTS"
    case paymentMachinesView = "ATM"
}

enum FlowNames: String {
    case addMoney = "AddMoney"
}
