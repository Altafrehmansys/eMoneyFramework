//
//  ReviewEidInteractor.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 22/04/2023.
//  
//

import Foundation

class ReviewEidInteractor {
    // MARK: Properties

    weak var output: ReviewEidInteractorOutputProtocol?

}

extension ReviewEidInteractor: ReviewEidInteractorProtocol {
    //Implement your services
    func getOcrAnalyze(request:OCRAnalyzeRequestModel) {
        Task{
            do {
                let ocrData:OCRAnalyzeResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.ocrAnalyze(param: request))
                await MainActor.run{
                    output?.onFetchOcrAnalyzeResponse(response: ocrData?.data)
                }
            } catch let error as AppError{
                await MainActor.run{
                    output?.onFetchOcrAnalyzeError(error:error)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func updateDocument(request:UpdateDocumentRequestModel) {
        Task{
            do {
                let updateData:UpdateDocumentResponseModel? = try await ApiManager.shared.executeMultipart(OnboardingApiRouter.updateDocument(param: request))
                await MainActor.run{
                    output?.onUploadDocumentResponse(response: updateData?.data)
                }
            } catch let error as AppError{
                await MainActor.run{
                    output?.onUploadDocumentError(error:error)
                    print(error.localizedDescription)
                }
            }
        }
    }
}
