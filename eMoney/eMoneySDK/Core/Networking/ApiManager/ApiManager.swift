//
//  ApiManager.swift
//  project-structure
//
//  Created by Shujaat Ali Khan on 07/03/2023.
//

import Foundation
import Alamofire

class ApiManager: NSObject {
    static let shared: ApiManager = ApiManager()
    
    private var session: Session?
    
    override init() {
        let urlSessionConfig = URLSessionConfiguration.af.default
        urlSessionConfig.timeoutIntervalForRequest = 30
        
//        let evaluators: [String: ServerTrustEvaluating] = [
//            "uat-swypapp.etisalat.ae": PublicKeysTrustEvaluator()
//        ]
//        let serverTrustManager = ServerTrustManager(evaluators: evaluators)
        
        //session = Session(configuration: urlSessionConfig, delegate: ApiManagerSessionDelegate())
        session = Session(configuration: urlSessionConfig)
    }
    
    func execute<T: Codable>(_ request: RequestProtocol) async throws -> T? {
        
        if !Connectivity.isConnectedToInternet {
            await MainActor.run{
                Loader.shared.hideFullScreen()
                CommonMethods.showInternetConnectionErrorScreen()
            }
            return nil
        }
        
        let dataTask = session!.request(request).serializingDecodable(T.self)
        let decodedResponse = await dataTask.response
        DataParser.logRequest(response: decodedResponse)
//        let decoded: T = try DataParser().parse(data: data.value)
        
        switch decodedResponse.result {
        case .success(let data):
            if let error = parseError(data: data) {
                throw error
            }else{
                return data
            }
        case .failure(let error):
            debugPrint(error)
            throw parseUrlSessionErrors(error: error)
        }
    }
    
    //Multipart request
    func executeMultipart<T: Codable>(_ request: RequestProtocol) async throws -> T? {
        guard let session = session else { throw AppError(errorDescription: "Network session found nil", errorCode: "",title: "") }
        
        let dataTask = session.upload(multipartFormData: { multiPart in
            for (key, value) in (request.finalParams) {
                multiPart.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
        }, with: request).serializingDecodable(T.self)
        
        let decodedResponse = await dataTask.response
        DataParser.logRequest(response: decodedResponse)
//        let decoded: T = try DataParser().parse(data: data.value)
        
        switch decodedResponse.result {
        case .success(let data):
            if let error = parseError(data: data) {
                throw error
            }else{
                return data
            }
        case .failure(let error):
            debugPrint(error)
            throw parseUrlSessionErrors(error: error)
        }
    }
    
    func parseError<T: Decodable>(data: T) -> AppError? {
        if let response = data as? BaseResponseModel {
            if response.responseCode == ApiResponseCode.SUCCESS || response.responseCode == ApiResponseCode.AML_FAILED { //|| response.responseCode == "200"
                return nil
            }else if response.responseCode == ApiResponseCode.SESSION_EXPIRED {
                NotificationCenter.default.post(name: .appSessionExpired, object: nil)
                return AppError(errorDescription: response.responseMessage ?? "", errorCode: response.responseCode ?? "",title: "")
            }else{
               var errorMessage = response.responseMessage ?? ""
                if errorMessage == "FAILED" {
                    errorMessage = "splash_error".localized
                }
                return AppError(errorDescription: errorMessage, errorCode: response.responseCode ?? "",title: response.title ?? "")
            }
        }else{
            return AppError(errorDescription: Strings.Generic.generalErrorMsg, errorCode: "",title: Strings.Generic.somethingWentWrong)
        }
    }
    
    func parseUrlSessionErrors(error:AFError) -> AppError {
        switch error {
        case .sessionTaskFailed(let err):
            let nsError = err as NSError
            return AppError(errorDescription: Strings.Generic.generalErrorMsg, errorCode: nsError.code.description,title: Strings.Generic.somethingWentWrong)
        default:
            return AppError(errorDescription: error.errorDescription ?? "", errorCode: error.responseCode?.description ?? "",title: "")
        }
    }
}
//
class ApiManagerSessionDelegate: SessionDelegate {

   override func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

       guard let trust = challenge.protectionSpace.serverTrust else {
           completionHandler(.cancelAuthenticationChallenge, nil)
           return
       }
       let pinner = PublicKeyPinner()
       if pinner.validate(serverTrust: trust) {
           completionHandler(.useCredential, nil)
       } else {
           completionHandler(.cancelAuthenticationChallenge, nil)
       }

   }

}


