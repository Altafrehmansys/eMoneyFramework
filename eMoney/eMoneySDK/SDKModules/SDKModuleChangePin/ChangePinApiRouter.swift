//
//  ChangePinApiRouter.swift
//  eMoneySDK
//
//  Created by Altaf Ur Rehman on 27/10/2023.
//

import Foundation

enum ChangePinApiRouter: RequestProtocol {
    case changePin(param:ReEnterYourPINRequestModel)
    
    var path: String {
        switch self {
        case .changePin:
            return EndPoints.Profile.changePin
        }
    }
    
    var params: [String:Any] {
        switch self{
        case .changePin(let param):
            return CommonMethods.codableToDictionary(codableObject: param)
        }
    }
    var requestType: RequestType {
        switch self {
        case .changePin:
            return .POST
        }
    }
    
    var headers: [String : String]{
        switch self {
        default:
            return [:]
        }
    }
    
}
