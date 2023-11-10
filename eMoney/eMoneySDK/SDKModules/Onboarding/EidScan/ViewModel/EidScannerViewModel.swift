//
//  EidScannerViewModel.swift
//

import Foundation
import MDRSDK
import UIKit

class EidScannerViewModel{
    
    var documentType : DocumentType?
    var sdkResponseData: MDROutput?
    var frontImage: UIImage?
    var backImage: UIImage?
    var showResult: Bool = false

    //var resutlDataModel: EFRResultsDataModel? = EFRResultsDataModel()
    //var eIdDataModel: OCRAnalyzeResponseModel = OCRAnalyzeResponseModel()
    
   // var documentResult : Observable<MDRResponseModel?> = Observable(nil)
    var alertMessage: Observable<String> = Observable("")
    var alertMessageSuccess: Observable<String> = Observable("")
    var resultSuccess: Observable<Bool> = Observable(false)
    var showLoader: Observable<Bool> = Observable(false)
    
    var sdkMsg: Observable<String> = Observable("")
    var eidBackScaning: Observable<Bool> = Observable(false)

    init(docType: DocumentType){
        self.documentType = docType
        DocumentReaderSDK.getScannerOverlayView()?.overrideUserInterfaceStyle = .light
    }
    
    func backBtnPress(){
        DocumentReaderSDK.closeDocumentReader()
    }
    
//    func continuePress(view: UIView){
//
//        guard self.documentType != .EMIRATES_ID_CARD_FRONT else{
//            self.documentType = .EMIRATES_ID_CARD_BACK
//            self.readDocument(view: view)
//            return
//        }
//        if let docData = sdkResponseData{
//            //self.readDocumentDataFromImage(documentData: docData)
//            self.getDocumentDataFromServer(documentData: docData)
//        }
//    }
    
//    func readDocument(view: UIView){
//        self.showPreviewView.value = false
//        guard let docType = self.documentType else{
//            return
//        }
//        DocumentReaderSDK.delegate = self
//        self.setupInstructionMessage()
//
//        // Water mark is removed as per ticket https://eandmoney.atlassian.net/browse/EB-505
//        var image = UIImage(named: "")
////        var image = UIImage(named: "water")
////
////        if docType == .EMIRATES_ID_CARD_FRONT {
////            image = UIImage(named: "water")
////        } else {
////            image = UIImage(named: "water-back")
////        }
//
//        DocumentReaderSDK.showDocumentReader(on: view, docType, image, callBack: { result, status, feedStatus,feedBack  in
//                //print(result)
//            switch feedStatus{
//                case .ERROR:
//                    print(feedBack?.description ?? "error")
//                    self.alertMessage.value = feedBack?.description ?? "error"
//                case .CANCEL:
//                    print(feedBack?.description ?? "cancel")
//                case .COMPLETE:
//                    if let docData = result{
//                        self.sdkResponseData = docData
//                       // self.readDocumentDataFromImage(documentData: docData)
//                    }
//                @unknown default:
//                    print("")
//            }
//        })
//    }
    func readDocument(view: UIView){
//        guard let docType = self.documentType else{
//            return
//        }
        DocumentReaderSDK.delegate = self
        DocumentReaderSDK.setStrokeWidth(5.0)
        let scanParameter:(hintImages: [UIImage],docType: DocumentType,isMRZ:Bool,onlyMRZPage:Bool) = ([UIImage(named: "WaterMarkEIDFront")!,UIImage(named: "WaterMarkEIDBack")!],.ID_CARD,false,false)
        
        DocumentReaderSDK.showDocumentReader(on: view, documentType: scanParameter.docType,forceMRZ: scanParameter.isMRZ,readMRZPageOnly: scanParameter.onlyMRZPage,hintImages:scanParameter.hintImages, callBack: { result, status, feedStatus,feedBack  in
                //print(result)
            switch feedStatus{
                case .TIMEOUT:
                    print(feedBack?.description ?? "timeout")
                    self.alertMessage.value = feedBack?.description ?? "error"
                case .ERROR:
                    print(feedBack?.description ?? "error")
                    self.alertMessage.value = feedBack?.description ?? "error"
                case .CANCEL:
                    print(feedBack?.description ?? "cancel")
                case .COMPLETE:
                    print("Scanning Completed")
                    //self.resultHandling(result: result)
                if let docData = result{
                    self.sdkResponseData = docData
                    //self.getDocumentDataFromServer(documentData: docData)
                    self.resultSuccess.value = true
                }
                @unknown default:
                    print("")
            }
        })
    }

    
 // Comment SDK api call
//    func readDocumentDataFromImage(documentData: MDROutput){
//        self.showLoader.value = true
//        APIClient.shared.readDataFromSDKResult( documentData: documentData) { success, result,message  in
//            self.showLoader.value = false
//            if success{
//                self.documentResult.value = result
//
//                let resultVMData = ResultViewmodel(resultFromScan: self.documentResult.value)
//                print(resultVMData)
//                resultVMData.setdata()
//                self.resutlDataModel = resultVMData.getResultDataModelObject()
//
//                self.resultSuccess.value = true
//            }
//            else{
//                self.alertMessage.value = message ?? "Error"
//            }
//        }
//    }
    
//    func getDocumentDataFromServer(documentData: MDROutput){
//        let bundleID = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.bundleIdentifier
//
//        let requestModel = OCRAnalyzeRequestModel()
//        requestModel.bundleId = bundleID ?? ""
//        requestModel.document = documentData.imageFront
//        requestModel.documentBack = documentData.imageBack
//
//        if let msisdn = CommonMethods.getMsisdnFromKeychainIfExists(), !msisdn.isEmpty {
//            requestModel.msisdn = msisdn
//        }else if let msisdn = CommonMethods.getTempMsisdnFromKeychainIfExists() {
//            requestModel.msisdn = msisdn
//        }else{
//            requestModel.msisdn = ""
//        }
//
//        self.showLoader.value = true
//        NetworkManager.sharedInstance().executeRequest("registration/ocr/analyze", withInput: requestModel) { response in
//            self.showLoader.value = false
//            print(response)
//
//            if let responseData = response as? OCRAnalyzeResponseModel {
//
//                self.eIdDataModel = responseData
//
//                self.resultSuccess.value = true
//            }
//
//        } failureBlock: { error in
//            self.showLoader.value = false
//            print(error.debugDescription)
//            self.alertMessage.value = error.errorDescriptionEn ?? "Error"
//        }
//    }
}


extension EidScannerViewModel : DocumentReaderDeligate{
    func onStateChange(documentType: DocumentType, pageIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.50) {
            if let overlayView = DocumentReaderSDK.getScannerOverlayView(){
                if pageIndex == 1{
                    self.addFrame(overlayView: overlayView)
                }
            }
        }
    }
    
    func onImageCaptured(image: UIImage, documentType: DocumentType,pageIndex:Int) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.50) {
            if let overlayView = DocumentReaderSDK.getScannerOverlayView(){
                if pageIndex == 1 && documentType == .ID_CARD{
                    self.flip(overlayView: overlayView)
                    self.eidBackScaning.value = true
                }
                
            }
        }
        
        if pageIndex == 1 && documentType == .ID_CARD{
            self.frontImage = image
        }else{
            self.backImage = image
        }
        
    }
    
    func feedbackMessage(message: String) {
        self.sdkMsg.value = message
    }
    
    //Flip Action
    func flip(overlayView:UIView) {
        let backImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: overlayView.bounds.width, height: overlayView.bounds.height))
        backImageView.image = UIImage(named: "WaterMarkEIDBack")
        let frontImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: overlayView.bounds.width, height: overlayView.bounds.height))
        frontImageView.image = UIImage(named: "WaterMarkEIDFront")
        backImageView.contentMode = .scaleAspectFit
        frontImageView.contentMode = .scaleAspectFit
        overlayView.addSubview(frontImageView)
        backImageView.translatesAutoresizingMaskIntoConstraints = true
        frontImageView.translatesAutoresizingMaskIntoConstraints = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.transition(from: frontImageView, to: backImageView, duration: 1.5, options: .transitionFlipFromRight, completion: {_ in
                frontImageView.removeFromSuperview()
                backImageView.removeFromSuperview()
                DocumentReaderSDK.go()
            })
        }
    }
    
    //Add fram
    func addFrame(overlayView:UIView){
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: overlayView.bounds.width, height: overlayView.bounds.height))
        imgView.image = UIImage(named: "eid-scan-frame")
        imgView.contentMode = .scaleAspectFit
        overlayView.addSubview(imgView)
        DocumentReaderSDK.go()
    }
    

    
}

