//
//  CaptureIdentityInfoPresenter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 15/04/2023.
//  
//

import Foundation

class CaptureIdentityInfoPresenter: CaptureIdentityInfoPresenterProtocol {

    // MARK: Properties

    weak var view: CaptureIdentityInfoViewProtocol?
    var router: CaptureIdentityInfoRouterProtocol?
    var interactor: CaptureIdentityInfoInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var isScreenTypeSelfi: Bool = false
}

extension CaptureIdentityInfoPresenter {
    
    func loadData() {
        makeDataSource()
    }
    
    func makeDataSource() {
        dataSource = []
        if isScreenTypeSelfi {
            let cel = CaptureIdentityImageCellModel.init(isSelfiScan: isScreenTypeSelfi)
            dataSource.append(CaptureIdentityImageCellModel.init(isSelfiScan: isScreenTypeSelfi))
            dataSource.append(CaptureIdentityTipsCellModel.init(title: "tip_for_video_1", imgName: "lamp-charge"))
            dataSource.append(CaptureIdentityTipsCellModel.init(title: "tip_for_video_2", imgName: "emoji-normal"))
            dataSource.append(CaptureIdentityTipsCellModel.init(title: "tip_for_video_3", imgName: "sun"))
            dataSource.append(CaptureIdentityTipsCellModel.init(title: "tip_for_video_4", imgName: "flash"))
        }else{
            let cel = CaptureIdentityImageCellModel.init(isSelfiScan: isScreenTypeSelfi)
            dataSource.append(CaptureIdentityImageCellModel.init(isSelfiScan: isScreenTypeSelfi))
            dataSource.append(CaptureIdentityTipsCellModel.init(title: "tip_for_photo_1", imgName: "flash"))
            dataSource.append(CaptureIdentityTipsCellModel.init(title: "tip_for_photo_2", imgName: "personalcard_Eid"))
            dataSource.append(CaptureIdentityTipsCellModel.init(title: "tip_for_photo_3", imgName: "card-slash"))
        }
        
        

        view?.reloadData()
    }
    
    func moveToEidScanScreen() {
        router?.go(to: .eidScanScreen)
    }
    
    func moveToLivenessCheck() {
        router?.go(to: .livenessCheck)
    }
}

extension CaptureIdentityInfoPresenter: CaptureIdentityInfoInteractorOutputProtocol {
    
}
