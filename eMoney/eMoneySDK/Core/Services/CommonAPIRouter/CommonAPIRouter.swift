//
//  CommonAPIRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 14/06/2023.
//

import Foundation

enum CommonAPIRouter: RequestProtocol {
    case getCountries
    case getNetworkProviders(countryCode: String)
    case validatePhone(phoneNumber: String, accountNumber: String, serviceId: String, pinNumber: String?)
  
    var path: String {
        switch self {
        case .getCountries:
            return EndPoints.Common.getCountries
        case .getNetworkProviders:
            return EndPoints.Common.getNetworkProviders
        case .validatePhone:
            return EndPoints.Common.validatePhoneNumber
            
        }
    }
    
    var params: [String:Any] {
        switch self {
        case .getCountries:
            return ["rechargeType": "MOBILE"]
        case let .getNetworkProviders(countryCode):
            return ["countryISO": countryCode,
                    "rechargeType": "MOBILE"]
        case let .validatePhone(phoneNumber, accountNumber, serviceId, providerPin):
            var params: [String:Any] = ["msisdn": phoneNumber,
                          "serviceId" : serviceId,
                                        "pin":UserDefaultHelper.userLoginPin,
                          "linkedAccount": true,
                          "accountNumber": accountNumber,
                          "flowName": "Upgrade",
                          "userToken":UserDefaultHelper.userSessionToken]
            if providerPin != nil {
                params["providerPin"] = providerPin
            }
            return params
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .getCountries, .getNetworkProviders, .validatePhone:
            return .POST
        }
    }
}
