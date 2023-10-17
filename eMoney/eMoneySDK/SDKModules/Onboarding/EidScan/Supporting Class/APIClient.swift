    //
    //  APIClient.swift
    //

/* ----------------

import UIKit
import Foundation
import os.log
import SystemConfiguration
import MDRSDK

internal class APIClient : NSObject{
    
    static let shared = APIClient()
    static var baseURL = ""
        // MARK: - Login AICenter
    
    typealias CompletionHandlerLogin = (_ success:Bool,_ message :String) -> Void
    var rhServTocken:String = ""
    func Loginwith(userName:String,password:String,completionHandler: @escaping  CompletionHandlerLogin){
        
        let urlStr = APIClient.baseURL + "/auth/access/login"
        
        let dataPara = [
            "email": userName,
            "password": password
        ]
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(dataPara) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                    // print(jsonString)
                let postData = jsonString.data(using: String.Encoding.utf8)!
                self.callApi(url: urlStr, type: .POST, postData: postData) { success, statusCode, errorMessage, resultData in
                    switch (statusCode)
                    {
                        case 200:
                        print("Loginwith result success")
                        if success{
                            do {
                                let json = try JSONSerialization.jsonObject(with: resultData!, options: .mutableContainers) as? [String: Any]
                                print("====== Login Livness Response json \(json ?? [:])")
                                
                                if json?.count ?? 0 > 0{
                                    if let data = json?["data"] as? [String:Any]{
                                        if let token = data["token"] as? String{
                                            self.rhServTocken = token
                                            completionHandler(true,token)
                                        } else {
                                            completionHandler(false, "error- Token Error")
                                        }
                                    }
                                    
                                } else {
                                    completionHandler(false, "error- \(errorMessage)")
                                }
                            } catch {
                                
                                print("Something went wrong")
                                completionHandler(false, "error- \(errorMessage)")
                            }
                        }else{
                            completionHandler(false, "error- \(errorMessage)")
                        }
                        break
                        case 400:
                        print("Loginwith  validation error 400- \(errorMessage)")
                        completionHandler(false, "error")
                        return
                        case 401:
                        print("Loginwith Authentication error- \(errorMessage)")
                        completionHandler(false, "token")
                        return
                        case 404:
                        print("Loginwith url error- \(errorMessage)")
                        completionHandler(false, "error")
                        return
                        case 500:
                        print("Loginwith Authentication error- \(errorMessage)")
                        completionHandler(false, "config")
                        return
                        case 1003:
                        print("Loginwith Authentication error- \(errorMessage)")
                        completionHandler(false, "Please check your network")
                        return
                        default:
                        completionHandler(false, "error")
                        print("Loginwith got response \(statusCode) - \(errorMessage)")
                    }
                }
                
            }else {
                completionHandler(false, "error")
            }
        }else {
            completionHandler(false, "error")
        }
    }
    
    typealias CompletionHandlerReadData = (_ success:Bool,_ result :MDRResponseModel?,_ message: String?) -> Void
    
    func readDataFromSDKResult(documentData: MDROutput,completionHandler: @escaping CompletionHandlerReadData ){
        let urlStr = APIClient.baseURL +  "/v3/sdk/ocr/analyze"
        let bundleID = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.bundleIdentifier
        var parameter: [String:Any] = [
            "bundleId": bundleID ?? "",
        ]
        parameter["document"] = documentData.imageFront
        if let backBase64 = documentData.imageBack{
            parameter["documentBack"] = backBase64
        }
        
        
        let parameters = self.dicToJsonString(dictionary: parameter)
        let postData = parameters.data(using: .utf8)
        
        self.callApi(url: urlStr, type: .POST, postData: postData) { success, statusCode, errorMessage, resultData in
            switch (statusCode)
            {
                case 200:
                print("Read Document   result success")
                if success{
                    do {
                            // make sure this JSON is in the format we expect
                            // convert data to json
                        if let json = try JSONSerialization.jsonObject(with: resultData!, options: []) as? [String: Any] {
                                // try to read out a dictionary
                            print(json)
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                    let decoder = JSONDecoder()
                    
                    if let result = try? decoder.decode(MDRResponseModel.self, from: resultData!) {
                        completionHandler(true, result, "success")
                    }
                    else{
                        completionHandler(false,nil,"Error: Trying to convert JSON data to Object")
                        
                    }
                    
                    
                }else{
                    completionHandler(false, nil, errorMessage)
                }
                break
                case 400:
                print("Read Document  Bad Request error 400- \(errorMessage)")
                completionHandler(false, nil,"Validation error 400- \(errorMessage)")
                return
                case 401:
                print("Read Document   Authentication error- \(errorMessage)")
                completionHandler(false, nil, "Authentication error- \(errorMessage)")
                return
                case 404:
                print("Read Document   url error- \(errorMessage)")
                completionHandler(false, nil, "url error- \(errorMessage)")
                return
                
                default:
                completionHandler(false, nil, "\(statusCode) - \(errorMessage)")
                print("Read Document   got response \(statusCode) - \(errorMessage)")
            }
        }
        
        
        
    }
    
}
extension APIClient{
    private func dicToJsonString(dictionary : [String:Any]) -> String{
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            let theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
                //print("JSON string = \(theJSONText!)")
            return theJSONText ?? ""
        }
        return ""
    }
}

extension APIClient{
    
    func callApi(url:String,type:APIType,postData:Data?,completionHandler: @escaping   (_ success:Bool,_ statusCode :Int,_ errorMessage :String, _ resultData:Data?) -> Void){
        
        
        if Reachability.isConnectedToNetwork(){
            
            var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
            request.httpMethod = type == .GET ? "GET": "POST"
            if let data = postData{
                request.httpBody = data
            }
            request.timeoutInterval = 30.0
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(self.rhServTocken )", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request ) { (data: Data?, reponse: URLResponse?, error: Error?) in
                
                if let httpResponse = reponse as? HTTPURLResponse
                {
                
                switch (httpResponse.statusCode)
                {
                    case 200:
                    print("result success")
                    if let `data` = data {
                        completionHandler(true,httpResponse.statusCode, "", `data`)
                    }else{
                        completionHandler(false,httpResponse.statusCode, "", nil)
                    }
                    break
                    case 400:
                    completionHandler(false,httpResponse.statusCode, "", nil)
                    return
                    case 401:
                    completionHandler(false,httpResponse.statusCode, getErrorMessage(code: httpResponse.statusCode), nil)
                    return
                    case 404:
                    completionHandler(false,httpResponse.statusCode, getErrorMessage(code: httpResponse.statusCode), nil)
                    return
                    case 500:
                    completionHandler(false,httpResponse.statusCode, getErrorMessage(code: httpResponse.statusCode), nil)
                    return
                    default:
                    print(" got response \(httpResponse.statusCode)")
                    completionHandler(false,httpResponse.statusCode, getErrorMessage(code: httpResponse.statusCode), nil)
                }
                }else{
                    completionHandler(false,1002, getErrorMessage(code: 1002), nil)
                }
                func getErrorMessage(code:Int) -> String{
                    if let err = error {
                        print("====== doAnalysis Response error \(err.localizedDescription)")
                        return err.localizedDescription
                    }else{
                        return "error"
                    }
                }
                
            }
            task.resume()
        }else{
            completionHandler(false,1003, "network error", nil)
        }
    }
}

internal class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
            // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
enum APIType:Int{
    case GET
    case POST
}

---------------- */
