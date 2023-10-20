//
//  DataParser.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 03/03/2023.
//

import Foundation
import Alamofire

protocol DataParserProtocol {
    func parse<T: Decodable>(data: Data) throws -> T
}

class DataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func parse<T: Decodable>(data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
   
    class func logRequest<T: Codable>(response: DataResponse<T, AFError>) {
        guard SDKColors.shared.logsEnabled else {
            return
        }
        
        var dataJSON = response.data?.prettyJSONString() ?? ""
        
        print("\n✅✅✅✅✅========================== REQUEST START ==========================✅✅✅✅✅\n")
        
        if let url = response.request?.url?.absoluteString {
            print("URL: \n\(url)\n")
        }
        
        if let method = response.request?.httpMethod {
            print("METHOD: \n\(method)\n")
        }
        
        if let headers = response.request?.allHTTPHeaderFields {
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: headers,
                options: []) {
                print("HEADERS: \n\(theJSONData.prettyJSONString()!)")
            }
        }
        
        if let body = response.request?.httpBody?.prettyJSONString() {
            print("REQUEST: \n\(body)\n")
        }
        
        if dataJSON.isEmpty {
            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                dataJSON = responseString
            }
        }
        print("RESPONSE: \n\(dataJSON)\n")
        
        print("✅✅✅✅✅========================== REQUEST END ==========================✅✅✅✅✅")
        print("\n")
    }
    
}
