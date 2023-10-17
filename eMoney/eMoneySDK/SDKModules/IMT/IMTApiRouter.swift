//
//  IMTApiRouter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 27/05/2023.
//

import Foundation

enum IMTApiRouter: RequestProtocol {
    case getCountrie

    
    var path: String {
        switch self {
        case .getCountrie:
            return EndPoints.IMT.getCountries
        }
    }
    
    var params: [String:Any] {
        switch self{
        case .getCountrie:
            return [:]
            
        }
    }
    var requestType: RequestType {
        switch self {
        case .getCountrie:
            return .POST
        }
    }
    
}
