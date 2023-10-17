//
//  RequestApi.swift
//  StructureProject
//
//  Created by Muhammad Hassan Shafi on 03/03/2023.
//

import Foundation
import Alamofire

enum RequestType: String {
    case GET
    case POST
    case PUT
    case DELETE
    
    var method: HTTPMethod {
        switch self {
        case .GET:
            return .get
        case .POST:
            return .post
        case .PUT:
            return .put
        case .DELETE:
            return .delete
        }
    }
}
