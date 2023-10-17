//
//  ReviewEidContract.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 22/04/2023.
//  
//

import Foundation

protocol ReviewEidViewProtocol: ViperView {
   // func onOcrAnalyzeResponse(languageData: OCRAnalyzeData)
}

protocol ReviewEidPresenterProtocol: ViperPresenter {
    func loadData(updateType:UserUpdateType?)
    func getOcrAnalyze(imageFront:String?,imageBack:String?)
}

protocol ReviewEidInteractorProtocol: ViperInteractor {
    func getOcrAnalyze(request:OCRAnalyzeRequestModel)
    func updateDocument(request:UpdateDocumentRequestModel)
}

protocol ReviewEidInteractorOutputProtocol: AnyObject {
    func onFetchOcrAnalyzeResponse(response : OCRAnalyzeData?)
    func onFetchOcrAnalyzeError(error : AppError)
    
    func onUploadDocumentResponse(response : UpdateDocumentData?)
    func onUploadDocumentError(error : AppError)
}

protocol ReviewEidRouterProtocol: ViperRouter {
    func go(to route: ReviewEidRouter.Route)
}
