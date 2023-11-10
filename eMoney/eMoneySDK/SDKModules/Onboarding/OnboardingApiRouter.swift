//
//  OnboardingApiRouter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 07/03/2023.
//

import Foundation

enum OnboardingApiRouter: RequestProtocol {
    case languagePack(langCode:String?)
    case checkAppVersion
    case allLanguages
    case walkthrough(param:WalkthroughRequestModel)
    case registerationStatus(param:RegisterMobileNumberRequestModel)
    case otpSendToMobile(param:VerifyMobileNumberOtpSendRequestModel)
    case otpVerifyNumber(param:VerifyMobileNumberOtpVerifyRequestModel)
    case ocrAnalyze(param:OCRAnalyzeRequestModel)
    case updateDocument(param:UpdateDocumentRequestModel)
    case keyAndConfiguration
    case liveness(command:String)
    case rhserv(param:EFRServerValidationRequest)
    case login(param:LoginRequestModel)
    case termsAndCondition(param:TermsConditionsRequestModel)
    case registerUser(param:RegistrationRequestModel)
    case initiatePin(param:InitiatePinRequestModel)
    case resetPin(param:ResetPinRequestModel)
    case lookUp(param:RegistrationMethodsRequestModel)
    case verifyEmail(email:String)
    case cardColor(param:SelectCardRequestModel)
    case getToken(token: String)
    case forgetPinSendOtp
    case updateProfile(params: UpdateProfileRequest)
    
    var path: String {
        switch self {
        case .languagePack:
            return EndPoints.Language.languagePack
        case .checkAppVersion:
            return EndPoints.Onboarding.checkAppVersion
        case .walkthrough:
            return EndPoints.Onboarding.walkthrough
        case .registerationStatus:
            return EndPoints.Onboarding.registerationStatus
        case .otpSendToMobile:
            return EndPoints.Onboarding.otpSend
        case .forgetPinSendOtp:
            return EndPoints.Onboarding.forgetPin
        case .otpVerifyNumber:
            return EndPoints.Onboarding.otpVerify
        case .allLanguages:
            return EndPoints.Language.allLanguages
        case .ocrAnalyze:
            return EndPoints.Onboarding.ocrAnalyze
        case .updateDocument:
            return EndPoints.Onboarding.updateDocument
        case .keyAndConfiguration:
            return EndPoints.Onboarding.keyAndConfiguration
        case .liveness:
            return EndPoints.Onboarding.liveness
        case .rhserv:
            return EndPoints.Onboarding.rhserv
        case .login:
            return EndPoints.Onboarding.login
        case .termsAndCondition:
            return EndPoints.Onboarding.termsAndCondition
        case .registerUser:
            return EndPoints.Onboarding.register
        case .initiatePin:
            return EndPoints.Onboarding.initiatePin
        case .resetPin:
            return EndPoints.Onboarding.resetPin
        case .lookUp:
            return EndPoints.Onboarding.lookup
        case .verifyEmail:
            return EndPoints.Onboarding.verifyEmail
        case .cardColor:
            return EndPoints.Onboarding.cardColor
        case .getToken:
            return EndPoints.Onboarding.tokenGetter
        case .updateProfile:
            return EndPoints.Onboarding.tokenGetter
        }
    }
    
    var queryParameters: [String: String] {
        switch self {
        case .getToken:
            return [:]
//            return ["authorization":token]
        default:
            return [:]
        }
    }
    
    var params: [String:Any] {
        switch self{
        case .languagePack(let langCode):
            if let code = langCode {
                return ["lang":code]
            }else{
                return [:]
            }
            
        case .allLanguages:
            return [:]
        case .checkAppVersion:
            return [:]
        case .walkthrough(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .login(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .registerationStatus(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .otpSendToMobile(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .forgetPinSendOtp:
            return [:]
        case .otpVerifyNumber(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .ocrAnalyze(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .updateDocument(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .keyAndConfiguration:
            return [:]
        case .liveness(let command):
            return ["command":command]
        case .rhserv(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .termsAndCondition(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .registerUser(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .initiatePin(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .resetPin(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .lookUp(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .verifyEmail(let email):
            return ["email":email]
        case .cardColor(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        case .getToken:
            return [:]
        case .updateProfile(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
            
        }
    }
    var requestType: RequestType {
        switch self {
        case .checkAppVersion,.languagePack,.allLanguages:
            return .POST
        case .walkthrough,.ocrAnalyze,.keyAndConfiguration,.liveness,.rhserv,.registerUser,.verifyEmail,.updateDocument, .updateProfile:
            return .POST
        case .registerationStatus:
            return .POST
        case .otpSendToMobile, .forgetPinSendOtp:
            return .POST
        case .otpVerifyNumber:
            return .POST
        case .login:
            return .POST
        case .termsAndCondition:
            return .POST
        case .initiatePin:
            return .POST
        case .resetPin:
            return .POST
        case .lookUp:
            return .POST
        case .cardColor:
            return .POST
        case .getToken:
            return .POST
        }
    }
    
    var headers: [String : String]{
        switch self {
        case .registerUser:
//            return ["Content-Type":"multipart/form-data"]
            return ["Content-Type":"application/json"]
        case .getToken:
            let token = SDKColors.shared.authorizationToken
            return ["Authorization":token]
        default:
            return [:]
        }
    }
    
}
