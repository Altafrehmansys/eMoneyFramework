//
//  MParkingDetailsContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation

protocol MParkingDetailsViewProtocol: ViperView {
    
    var presenter: MParkingDetailsPresenterProtocol! { get set }
    func setupUI()
}

protocol MParkingDetailsPresenterProtocol: ViperPresenter {
    
    var dataSource: [StandardCellModel] { get }
    var navTitle:String { get set }
    var selectItemType:BillsAnsTopUpType { get set }
    var mParkingDetailsRegionResponseModel: MParkingDetailsRegionResponseeModel? { get set }
    var mParkingDetailsZoneResponseModel: MParkingDetailsZoneResponseeModel? { get set }
    var selectedRegion:ParkingRegion? { get set }
    var selectedZone:RegionZone? {get set}
    var selectedItem: ListItems? { get set }
    func loadData()
    func moveToAddNewVehicle()
    func getSMSDetails()
    func addParking(_ parking:ParkingRequestModel)
}

protocol MParkingDetailsInteractorProtocol: ViperInteractor {
    func getSMSDetails()
    func getRegionList(_ listType:String)
    func getZoneList()
    func addParking(_ parking:ParkingRequestModel)
}

protocol MParkingDetailsInteractorOutputProtocol: AnyObject {
    func onGetSMSDetails(Response response: ParkingSMSCopyResponseModel?)
    func onGetSMSDetails(Error error: AppError)
    
    func onGetRegionList(Response response: MParkingDetailsRegionResponseeModel?)
    func onGetRegionList(Error error: AppError)
    
    func onGetZoneList(Response response: MParkingDetailsZoneResponseeModel?)
    func onGetZoneList(Error error: AppError)
    
    func onAddParking(Response response: AddParkingResponseeModel?)
    func onAddParking(Error error: AppError)
}

protocol MParkingDetailsRouterProtocol: ViperRouter {
    func go(to route: MParkingDetailsRouter.Route)
}
