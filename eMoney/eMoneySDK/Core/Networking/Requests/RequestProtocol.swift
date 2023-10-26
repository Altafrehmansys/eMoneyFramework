//
//  RequestProtocol.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 07/03/2023.
//

import Foundation
import Alamofire

protocol RequestProtocol:URLRequestConvertible {
    var path: String { get }
    var requestType: RequestType { get }
    var headers: [String: String] { get }
    var baseParams: [String:Any] { get }
    var params: [String:Any] { get }
    var queryParameters: [String: String] { get }
}

// MARK: - Default RequestProtocol
extension RequestProtocol {
    var baseURL: String {
        switch SDKColors.shared.environment {
        case .staging:
            return "https://enmoneyapim.azure-api.net/"
        case .production:
            return "https://enmoneyapim.azure-api.net/"
        case .none:
            return "https://enmoneyapim.azure-api.net/"
        }
//        return "https://preprod-digitalapp.etisalat.ae/mwallet-rest/api/"
        //        return Environment.serverURL
    }
    
    var baseParams: [String:Any] {
        let baseReq = CommonMethods.codableToDictionary(codableObject: BaseRequest())
        return baseReq
    }
    
    var queryParameters: [String: String] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var finalParams:[String:Any] {
        return baseParams.merging(params) { $1 }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = requestType.method
        
        
        request.headers.add(.contentType("application/json"))
        request.headers.add(HTTPHeader(name: "custom_header", value: "pre_prod"))
        
        // MARK: New Client id added
        #warning("New client id has been added here from the SDK side")
        if let clientID = SDKColors.shared.clientID {
            request.headers.add(HTTPHeader(name: "client_id", value: clientID))
        }
        
        if let accessToken = SDKColors.shared.accessToken {
            request.headers.add(HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)"))
        }
        if let partnerName = SDKColors.shared.partnerName {
            request.headers.add(HTTPHeader(name: "PartnerCode", value: partnerName))
        }
        
        //        request.headers.add(HTTPHeader(name: "Client-Id", value: ))
        
        //Enable this header when add language support
        //request.headers.add(.acceptLanguage("en"))
        
        //Adding Custom headers
        if !headers.isEmpty {
            for eachHeader in headers {
                request.headers.add(HTTPHeader(name: eachHeader.key, value: eachHeader.value))
            }
        }
        
        //Adding url query parameters
        if !queryParameters.isEmpty {
            do {
                request = try URLEncoding(destination: .queryString).encode(request, with: queryParameters)
            } catch {
                // Handle error.
                print(error.localizedDescription)
            }
        }
        
        let combineParam = baseParams.merging(params) { $1 }
        
        //Adding request body parameters
        if !combineParam.isEmpty {
            do{
                request = try JSONEncoding().encode(request, with: combineParam)
            }catch{
                print(error.localizedDescription)
                print("error when adding body params")
            }
        }
        
        return request
    }
    
}
