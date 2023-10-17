//
//  MParkingDetailsPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation
import UIKit

class MParkingDetailsPresenter {

    // MARK: Properties

    weak var view: MParkingDetailsViewProtocol?
    var router: MParkingDetailsRouterProtocol?
    var interactor: MParkingDetailsInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var collectionViewCellActions: StandardCellActions? = nil
    
    var navTitle: String = ""
    var selectedItem: ListItems? = nil
    var selectItemType: BillsAnsTopUpType = .none
    var mParkingDetailsRegionResponseModel: MParkingDetailsRegionResponseeModel? = nil
    var mParkingDetailsZoneResponseModel: MParkingDetailsZoneResponseeModel? = nil
    var selectedRegion:ParkingRegion? = nil
    var selectedZone:RegionZone? = nil
    
    class MethodType: MethodOptionsBaseTypes {
        enum CellType {
            case all
            case bank
            case mobile
            case employee
            case general
        }
       var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
            }
       }
}

extension MParkingDetailsPresenter: MParkingDetailsPresenterProtocol {
    
    func getSMSDetails() {
        self.interactor?.getSMSDetails()
    }
    func loadData() {
        view?.setupUI()
        Loader.shared.showFullScreen()
        self.interactor?.getRegionList("mParking")
        self.interactor?.getZoneList()
//        self.checkLocationPermission()
    }
    
    
    func moveToAddNewVehicle() {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(AddNewVehiclesTableViewCellModel(title:Strings.BillPayment.add_vehicle_details))
        dataSource.append(SpaceTableViewCellModel(height: 12))
        dataSource.append(ImageSelectorTableViewCellModel())
        dataSource.append(PlateTypeTableViewCellModel(plateTypePlaceholder:Strings.BillPayment.plate_kind,dropDownDataSource: ["Private","Self","Private"]))
        dataSource.append(SpaceTableViewCellModel(height: 12))
        dataSource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.pick_a_plate_source,font: AppFont.appSemiBold(size: .body3),color: AppColor.eAnd_Black_80))
        let collectionViewDataSource = setCollectionDataSource()
        dataSource.append(PlatSourceCollectionViewTableViewCellModel(actions: self.cellActions,dataSource: collectionViewDataSource, itemSize: CGSize(width: 300, height: 100), interItemSpacing:12.0))
        dataSource.append(ViewWithTextFieldTableViewCellModel(plateTypePlaceholder:Strings.BillPayment.enterPlateCode))
        dataSource.append(SpaceTableViewCellModel(height: 12))
        dataSource.append(ViewWithTextFieldTableViewCellModel(plateTypePlaceholder:Strings.BillPayment.enterPlateNumber))
        dataSource.append(SpaceTableViewCellModel(height: 12))
        
        let saveButton = BaseButton()
        saveButton.type = .PlainButton
        saveButton.setTitle(Strings.BillPayment.save_this_vehicle_for_mParking, for: .normal)
        saveButton.setImage(UIImage(named: "checked-icon"), for: .normal)
        saveButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left

        //saveButton.addTarget(self, action: #selector(removeBankAction), for: .touchUpInside)
        
        let addDevice = BaseButton()
        addDevice.type = .GradientButton
        addDevice.setTitle(Strings.BillPayment.add_this_vehicle, for: .normal)
       // addDevice.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        self.router?.go(to: .addNewVehicle(dataSource: dataSource, actions: [saveButton, addDevice,BaseButton()]))
    }
    
    private func setCollectionDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        self.mParkingDetailsRegionResponseModel?.data?.forEach({
            dataSource.append(SingleTitleCollectionViewCellModel(actions: self.collectionViewCellActions,
                                                                 title: /$0.title,
                                                                 methodType: MethodType(type: .all)))
        })
        return dataSource
    }
    private func checkLocationPermission() {
        switch LocationManager().currentLocationStatus() {
        case .authorizedWhenInUse,.authorized,.authorizedAlways:
            //FIXME:- Remove this presentatation and break statement
//            self.router?.go(to: .presentLocationPermission)
            break
        case .notDetermined:
            self.router?.go(to: .presentLocationPermission)
        default:break
        }
    }
}

extension MParkingDetailsPresenter: MParkingDetailsInteractorOutputProtocol {
    func addParking(_ parking: ParkingRequestModel) {
        Loader.shared.showFullScreen()
        self.interactor?.addParking(parking)
    }
    
    func onGetSMSDetails(Response response: ParkingSMSCopyResponseModel?) {
        if let response = response {
            self.router?.go(to: .presentParkingSMSCopy(response))
        }
    }
    
    func onGetSMSDetails(Error error: AppError) {
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.errorDescription)
    }
    
    func onGetZoneList(Response response: MParkingDetailsZoneResponseeModel?) {
        Loader.shared.hideFullScreen()
        self.mParkingDetailsZoneResponseModel = response
    }
    func onGetZoneList(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.errorDescription)
    }
    
    func onGetRegionList(Response response: MParkingDetailsRegionResponseeModel?) {
        self.mParkingDetailsRegionResponseModel = response
    }
    func onGetRegionList(Error error: AppError) {
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.errorDescription)
    }
    func onAddParking(Response response: AddParkingResponseeModel?) {
        Loader.shared.hideFullScreen()
        self.getSMSDetails()
    }
    func onAddParking(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.errorDescription)
    }
    
    
}
