//
//  EFROCRManager.swift
//  etisalatWallet
//
//  Created by Ghulam Mujtaba on 29/03/2022.
//  Copyright © 2022 Etisalat UAE. All rights reserved.
//

import UIKit
import Foundation
import MDRSDK

protocol EFROCRManagerDelegate: NSObjectProtocol {
    func documentReaderSDKAuthenticated()
    func documentReaderSDKInitialized()
    func documentReaderSDKAuthenticationFailed(_ errorString: String)
    func documentReaderSDKInitializationFailed(_ errorString: String)
}

@objc class EWalletEFROCRManager: NSObject {

    weak var delegate: EFROCRManagerDelegate?
    
    // MARK: - Properties
    
    let baseUrl = "https://rhservapi.server.aicenter.ae:12345"
    
    var selectedType: DocumentType = .ID_CARD
    
    // MARK: - Methods
    
    override init() {
        super.init()
        
        //APIClient.baseURL = baseUrl
        self.initdata()
        //self.initialiseSDKWithoutLogin()
        getConfig()
    }
    
    convenience init(delegate: EFROCRManagerDelegate?) {
        self.init()
        self.delegate = delegate
    }
    
    func initdata(){
        let version = "SDK Version : \(DocumentReaderSDK.getVersion.major).\(DocumentReaderSDK.getVersion.minor).\(DocumentReaderSDK.getVersion.patch)\nExpiry Date : \(DocumentReaderSDK.getVersion.expiryDate)"
        print(version)
        
        DocumentReaderSDK.setSDKEnableLogs(true)
    }
    
    func initialiseSDKWithoutLogin(dataString:String ){
        
        //            let sampleDataString = "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.qV72u48EryPWbro7baRkOw==.TvvTRnQV3qPAxaWFqbm2/nG/DWpFDmv/XDHXGsL5UFo=.J2M9udRsBc/XHg6A4GtaRgDOJJUFtb4zjTkmOuKsSbVgY9cf8wfParUXIdaGTmiU0YDidgucjXq1ZwduMrGCYnEMMoDCvQ0eSWHEhHQ8I+OdR0mnuxMeNO2TTqkaETxiCUC8+mOM7imE1r5babtov1yhlkT3Zi22lEkrGk2Fu7AzUuPHrLOeFB8RRRGkID897+LGdMJADh6tNVOkZvi3LbM+sjyp6Y6R8liDg3sB+sKCB2ccbuk32/Fs8GrNMuwPLfNKZgTkovwlLeKFghvcn84baI0woVAZ9WgHxz9PDEzi2p6JWrEd251mE75GNwzGeR4hJqkcCIwLrEWUH5d5dA==.LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUEwMnFSbjZTbk1WMlBTdlcwVzg0dQpNU2NwdWlOR0VIVVIzUlpOSFlzTkdORmxWQWpmcWZRK0FRdDVneWlGOHJKZTBYdjdQNVprc3NoY1N4NndReFJUCkRzaklsaS85cm9VV25DdlQrbG0rUkxOVklUZWZ3Vlo2YitEY2w2UXo0VldBVTdDdFJxakFvZk5yK21maEdidkwKSHIzTDB0OTVyYkpmSXc4TDByandxdjNjdHhsQUtQMnFncFEwTVh1dmxaeEhvUmJRWGpJTk5tNEI1aW1OWlg0SQo1K1dRSC9jMHhvZnFLZEU5R1FpMVF6Y2Ixcm1YbW42QjRBZS9VNEtOVzBwUjFOZ3dPdVFxNy85ZDRHMUxBcVgvCkJ0RHlVbHhTMGZpaTF1RTc5WWphS3pYVVU0TXJ0KytneVBibjV6ZTZjZWV6ZEx2aEdKWjNBSnpCOFJpWnZwSHkKRFFJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg=="
        
        DispatchQueue.main.async {
            
            Loader.shared.showFullScreen()
            let response:MDRLicenseConfig = MDRLicenseConfig(data: dataString)
            DocumentReaderSDK.initializeDocumentReader(configurationSettings: response) { feedBack, status in
                Loader.shared.hideFullScreen()
                if status{
                    self.delegate?.documentReaderSDKInitialized()
                }
                else{
                    //self.showNormalAlert(title: "Error", msg: feedBack.description, OKAction: nil)
                    print(feedBack.description)
                    self.delegate?.documentReaderSDKInitializationFailed(feedBack.description)
                }
            }
        }
    }
    
    func getConfig() {
        Loader.shared.showFullScreen()
        Task{
            do {
                let response:EFRKeyAndConfigResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.keyAndConfiguration)
                await MainActor.run{
                    Loader.shared.hideFullScreen()
                    if let configData = response?.data?.configuration?.data {
                        GlobalData.shared.keyAndConfiguration = response
                        initialiseSDKWithoutLogin(dataString: configData)
                    }
                }
            } catch {
                await MainActor.run{
                    Loader.shared.hideFullScreen()
                    self.delegate?.documentReaderSDKInitializationFailed(error.localizedDescription)
                }
                print(error.localizedDescription)
            }
        }
    }
}
