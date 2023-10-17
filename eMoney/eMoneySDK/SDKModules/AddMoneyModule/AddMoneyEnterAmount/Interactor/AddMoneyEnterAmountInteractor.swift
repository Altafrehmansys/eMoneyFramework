//
//  AddMoneyEnterAmountInteractor.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 28/04/2023.
//  
//

import Foundation

class AddMoneyEnterAmountInteractor {
    // MARK: Properties

    weak var output: AddMoneyEnterAmountInteractorOutputProtocol?

}

extension AddMoneyEnterAmountInteractor: AddMoneyEnterAmountInteractorProtocol {
    
    func getCardsListRequest() {
        Task {
            do {
                var request = WalletRegistrationRequestModel()
                request.pin = UserDefaultHelper.userLoginPin ?? ""
                
                let response: CardResponseObjectModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.listCards(param: request))
                await MainActor.run {
                    if let response {
                        output?.onCardsList(response: response)
                    }
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.on(error: error)
                }
            }
        }
    }
    
    func initializeCardPayment(with card: CardResponseObjectModel.CardResponseObjectDataModel, and amount: String) {
        Task {
            do {
                
                var request = InitializeCardPaymentRequestModel()
                request.cardTitle = card.cardTitle
                request.cardNumber = card.cardNumber
                request.maskedCardNumber = card.maskedCardNumber
                request.subtype = card.subtype
                request.status = card.status
                request.issuer = card.issuer
                request.brand = card.brand
                request.providerName = card.providerName
                request.providerUserName = card.providerUserName
                request.amount = amount
                request.pin = UserDefaultHelper.userLoginPin
                
                let response: InitializeCardPaymentResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.initializeCardPayment(param: request))
                await MainActor.run {
                    if let response {
                        output?.onCardPayment(response: response)
                    }
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.on(error: error)
                }
            }
        }
    }
    
    func finalizeCardPayment(transactionID: String) {
        Task {
            do {
                
                var request = FinalizeCardPaymentRequestModel()
                request.epgTransactionId = transactionID
                request.pin = UserDefaultHelper.userLoginPin
                
                let response: FinalizeCardPaymentResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.finalizeApplePayPayment(param: request))
                await MainActor.run {
                    if let response {
                        output?.onWalletFinalizeSuccess(response: response)
                    }
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.on(error: error)
                }
            }
        }
    }
}

// MARK: - Create Wallet Session
extension AddMoneyEnterAmountInteractor {
    
    func createWalletSession(transactionID: String, sessionID: String, customer: String) {
        
        // prepare json data
        let json: [String: Any] = [
            "WalletCreateSession":
                [
                    "TransactionID":transactionID,
                    "SessionID":sessionID,
                    "Customer":customer,
                    "UserName": "MOI"
                ]
        ]
        
        print(json)
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://demo-ipg.ctdev.comtrust.ae:2443/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                self.output?.onCreateWalletSession(error: error!)
                return
            }
            
            do {
                self.printJSON(from: data)
                let createWalletSessionJson = try JSONDecoder().decode(CreateWalletSessionModel.self, from: data)
                self.output?.onCreateWalletSession(response: createWalletSessionJson)
            } catch let error {
                self.output?.onCreateWalletSession(error: error)
            }
        }
        
        task.resume()
    }
    
    func submitPaymentRequest(paymentData: [AnyHashable : Any], transactionID: String, sessionID: String, customerName: String, storeName: String) {
        
        // prepare json data
        let paymentDataJson = ["paymentData":paymentData] as [AnyHashable: Any]
        
        let cardCryptogramPacketData: Data? = try? JSONSerialization.data(withJSONObject: paymentDataJson, options: [])
        let jsonPayload = NSString(data: cardCryptogramPacketData!, encoding: String.Encoding.utf8.rawValue) as String?
        
        let json: [String: Any] = [
            "WalletSubmitPayload":
                [
                    "TransactionID": transactionID,
                    "Terminal": "ApplePay",
                    "SessionID": sessionID,
                    "Store": storeName,
                    "WalletResponseJSON": jsonPayload ?? "",
                    "Customer": customerName,
                    "UserName": "MOI"
                ] as [String : Any]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://demo-ipg.ctdev.comtrust.ae:2443/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                debugPrint(error?.localizedDescription ?? "No data")
                self.output?.onSubmitPaymentError(error: error!)
                return
            }
            do {
                self.printJSON(from: data)
                let createWalletSessionJson = try JSONDecoder().decode(CreateWalletSessionModel.self, from: data)
                self.output?.onSubmitPaymentSuccess(response: createWalletSessionJson)
                
            } catch let error {
                self.output?.onSubmitPaymentError(error: error)
            }
        }
        
        task.resume()
    }
    
    private func printJSON(from data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let jsonPrettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            if let jsonString = String(data: jsonPrettyData, encoding: .utf8) {
                debugPrint(jsonString)
            }
        } catch {
            debugPrint("Error converting Data to JSON: \(error)")
        }
    }
}
