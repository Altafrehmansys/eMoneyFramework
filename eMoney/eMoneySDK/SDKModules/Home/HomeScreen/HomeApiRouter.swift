//
//  HomeApiRouter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 02/06/2023.
//

import Foundation

enum HomeApiRouter: RequestProtocol {
    case availableBalance
    
    
    var path: String {
        switch self {
        case .availableBalance:
            return EndPoints.Home.getAvailableBalance
        }
    }
    
    var params: [String:Any] {
        switch self{
        case .availableBalance:
            return [:]
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .availableBalance:
            return .POST
        }
    }
    
}
