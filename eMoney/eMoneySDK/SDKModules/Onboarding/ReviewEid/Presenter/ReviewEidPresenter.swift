//
//  ReviewEidPresenter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 22/04/2023.
//  
//

import Foundation

class ReviewEidPresenter {

    // MARK: Properties

    weak var view: ReviewEidViewProtocol?
    var router: ReviewEidRouterProtocol?
    var interactor: ReviewEidInteractorProtocol?
    
    var updateType:UserUpdateType?
}

extension ReviewEidPresenter: ReviewEidPresenterProtocol {
    
    func loadData(updateType:UserUpdateType?) {
        self.updateType = updateType
    }
    
    func getOcrAnalyze(imageFront: String?, imageBack: String?) {
        let bundleID = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.bundleIdentifier
        let request = OCRAnalyzeRequestModel(document: imageFront, documentBack: imageBack, bundleId: bundleID ?? "")
        Loader.shared.showFullScreen()
        interactor?.getOcrAnalyze(request: request)
    }
    
    func callUpdateDocumentApi() {
        
        guard let resutlDataModel = GlobalData.shared.userEidInfo else {
            return
        }

        var requestModel = UpdateDocumentRequestModel()
        
        requestModel.fullName = resutlDataModel.fullName ?? ""
        requestModel.nationality = resutlDataModel.nationalityIso3 ?? ""
        requestModel.dateOfBirth = resutlDataModel.dob ?? ""
        requestModel.expiryDate = resutlDataModel.expiry ?? ""
        requestModel.eidNumber = resutlDataModel.emiratesId ?? ""
        requestModel.gender = resutlDataModel.sex ?? ""
        requestModel.firstName = resutlDataModel.firstName ?? ""
        requestModel.secondName = resutlDataModel.middleName ?? ""
        requestModel.lastName = resutlDataModel.lastName ?? ""
        
        let profileName = GlobalData.shared.loginData?.profileName ?? ""
        requestModel.previousProfileName = profileName
        // check if user is physical kyc and upgradeToProfile is none then send same previousProfileName and profileName
        let upgradeScreen = GlobalData.shared.loginData?.upgradeScreen;
        if (upgradeScreen != nil && upgradeScreen != "none"){
            requestModel.profileName = GlobalData.shared.loginData?.upgradeToProfile ?? ""
        }else{
            requestModel.profileName = profileName
        }
        
        requestModel.isSingleAccount = GlobalData.shared.loginData?.isSingleAccount
        requestModel.pin = UserDefaultHelper.userLoginPin
        
        Loader.shared.showFullScreen()
        
        interactor?.updateDocument(request: requestModel)
    }
}

extension ReviewEidPresenter: ReviewEidInteractorOutputProtocol {
    
    func onFetchOcrAnalyzeResponse(response: OCRAnalyzeData?) {
        Loader.shared.hideFullScreen()
        if let responseData = response  {
            if !(responseData.documentMismatch ?? false) {
                GlobalData.shared.userEidInfo = responseData
//                if GlobalData.shared.msisdnStatusData?.eidEnable ?? false {
//                    router?.go(to: .enterEmail)
//                }else{
//
//                }
                if let type = self.updateType {
                    if type == .updateEid {
                        self.callUpdateDocumentApi()
                    } else {
                        self.router?.go(to: .verifyIdentity)
                    }
                }else{
                    self.router?.go(to: .verifyIdentity)
                }
                
            } else {
                Alert.showBottomSheetError(title: "Document Mismatch.", message: "")
            }
        }
    }
    func onFetchOcrAnalyzeError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
    }
    
    func onUploadDocumentResponse(response: UpdateDocumentData?) {
        Loader.shared.hideFullScreen()
        if let responseData = response  {
            GlobalData.shared.loginData?.upgradeScreen = responseData.upgradeScreen
            GlobalData.shared.loginData?.profileName = responseData.profileName
            GlobalData.shared.loginData?.upgradeToProfile = responseData.upgradeToProfile
            GlobalData.shared.userProfile = UserProfile(rawValue: responseData.profileName ?? "")
            router?.go(to: .dismissUpgradeFlow)
        }
    }
    
    func onUploadDocumentError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
    }
}


    func callUpdateDocumentApi() {

  
//            if self.isNavigateForScan {
//                if self.popToViewController != nil {
//                    self.navigationController?.popToViewController(ofClass: self.popToViewController!, animated: true)
//                }else{
//                    self.navigationController?.popToRootViewController(animated: true)
//                }
//            }else{
//                self.navigationController?.popToRootViewController(animated: true)
//            }


    }
