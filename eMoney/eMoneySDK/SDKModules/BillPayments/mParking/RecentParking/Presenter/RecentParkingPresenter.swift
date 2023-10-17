//
//  RecentParkingPresenter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 15/06/2023.
//  
//

import Foundation
import UIKit

class RecentParkingPresenter {

    // MARK: Properties

    weak var view: RecentParkingViewProtocol?
    var router: RecentParkingRouterProtocol?
    var interactor: RecentParkingInteractorProtocol?
    var datasource:[StandardCellModel] = []
    var cellActions:StandardCellActions? = nil
    var collectionViewCellActions: StandardCellActions? = nil
    var navTitle: String = ""
    var selectedItem: ListItems? = nil
    var selectItemType: BillsAnsTopUpType = .none
    var mParkingDetailsRegionResponseModel: MParkingDetailsRegionResponseeModel? = nil
    var vehicleList:[BillData] = [] {
        didSet {
            self.setupDatasource()
        }
    }
    var parkings:[Parking] = [] {
        didSet {
            self.setupDatasource()
        }
    }
    class MethodType: MethodOptionsBaseTypes {
        enum CellType {
            case parking
            case vehilcle
            case all
            case general
        }
        var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
        }
    }
    func setupDatasource() {
        var datasource:[StandardCellModel] = []
        datasource.append(GenericTitleAndButtonTableViewCellModel(actions: self.cellActions,
                                                                  title:Strings.BillPayment.recentParking,
                                                                  titleFontAndColor: (AppFont.appSemiBold(size: .body2), AppColor.eAnd_Black_80),
                                                                  buttonTitle:Strings.BillPayment.addAnother,
                                                                  methodType: MethodType(type: .parking)))
        self.parkings.forEach { (parking) in
            datasource.append(ParkingCellModel(leftImage: "du",
                                               title:parking.numberPlate,
                                               subTitle: parking.regionWithZone,
                                               parkingDuration: parking.timeLeft,
                                               dateTime:/parking.dateTime,
                                               timeLeft: /parking.timeLeft,
                                               extendHr: "Extend 1hr"))
            datasource.append(SingleLineCellModel(lineColor: AppColor.eAnd_Grey_30,
                                                  leftSpace: 24,
                                                  rightSpace: 24))
        }
        datasource.append(GenericTitleAndButtonTableViewCellModel(actions: self.cellActions,
                                                                  title:Strings.BillPayment.yourVehicle,
                                                                  titleFontAndColor: (AppFont.appSemiBold(size: .body2), AppColor.eAnd_Black_80),
                                                                  buttonTitle:Strings.BillPayment.addAnother,
                                                                  methodType: MethodType(type: .vehilcle)))
        self.vehicleList.forEach { (vehicle) in
            datasource.append(PlateViewTableViewCellModel(image: "emptyPlate",
                                                          plateCode: vehicle.accountTitle ?? "-",
                                                          plateNumber: vehicle.accountNumber ?? "-"))
        }
        self.datasource = datasource
        self.view?.reloadTableView()
    }
    func setupCellActions() {
        cellActions = StandardCellActions{ index, model in
            if let model = model as? GenericTitleAndButtonTableViewCellModel {
                switch  (model.methodType as? MethodType)?.type {
                case .parking:
                    self.router?.go(to: .vehicleMParking(navTitle: self.navTitle, selectedItem: self.selectedItem))
                default:
                    self.navigateToAddVehicles()
                }
            }
        }
    }
    func presentAddVehicle() {
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
    func navigateToAddVehicles() {
        Loader.shared.showFullScreen()
        self.interactor?.getRegionList("mParking")
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
}

extension RecentParkingPresenter: RecentParkingPresenterProtocol {
    
    func loadData() {
        self.setupCellActions()
        self.view?.setupUI()
        Loader.shared.showFullScreen()
        self.interactor?.getRecentParkings()
        self.interactor?.getVehciles(data: BillRequestModel(billTypeId: "22", billTypeName: "mParking"))
    }
}

extension RecentParkingPresenter: RecentParkingInteractorOutputProtocol {
    func onRecentParkingSuccess(data: RecentParkingResponseModel) {
        Loader.shared.hideFullScreen()
        self.parkings = data.data ?? []
    }
    func onRecentParkingSuccess(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.errorDescription)
    }
    
    func onGetVehicleSuccess(data: BillResponse) {
        Loader.shared.hideFullScreen()
        self.vehicleList = data.data ?? []
    }
    func onGetVehiclesFail(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.errorDescription)
    }
    
    func onGetRegionList(Response response: MParkingDetailsRegionResponseeModel?) {
        Loader.shared.hideFullScreen()
        self.mParkingDetailsRegionResponseModel = response
        self.presentAddVehicle()
    }
    func onGetRegionList(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.errorDescription)
    }
}
