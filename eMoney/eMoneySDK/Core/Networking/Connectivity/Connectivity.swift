//
//  Connectivity.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 08/03/2023.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager.default?.isReachable ?? false
    }
}
