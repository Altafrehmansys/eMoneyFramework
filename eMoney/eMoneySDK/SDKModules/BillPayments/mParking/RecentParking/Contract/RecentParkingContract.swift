//
//  RecentParkingContract.swift
//  e&money
//
//  Created by Usama Zahid Khan on 15/06/2023.
//  
//

import Foundation

protocol RecentParkingViewProtocol: ViperView {
    func setupUI()
    func reloadTableView()
}

protocol RecentParkingPresenterProtocol: ViperPresenter {
    func loadData()
    var datasource:[StandardCellModel] {get}
    var navTitle:String { get set }
    var selectItemType:BillsAnsTopUpType { get set }
}

protocol RecentParkingInteractorProtocol: ViperInteractor {
    func getRecentParkings()
    func getRegionList(_ listType:String)
    func getVehciles(data: BillRequestModel)
    func addVehcile()
}

protocol RecentParkingInteractorOutputProtocol: AnyObject {
    func onRecentParkingSuccess(data:RecentParkingResponseModel)
    func onRecentParkingSuccess(error:AppError)
    func onGetRegionList(Response response: MParkingDetailsRegionResponseeModel?)
    func onGetRegionList(Error error: AppError)
    func onGetVehicleSuccess(data: BillResponse)
    func onGetVehiclesFail(error: AppError)
}

protocol RecentParkingRouterProtocol: ViperRouter {
    func go(to route: RecentParkingRouter.Route)
}
