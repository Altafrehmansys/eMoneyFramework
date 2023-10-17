//
//  VehiclesAndTransportDetailContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation

protocol VehiclesAndTransportDetailViewProtocol: ViperView {
    var presenter: VehiclesAndTransportDetailPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    func setTextFields(_ type:VehicleFineType?)
}

protocol VehiclesAndTransportDetailPresenterProtocol: ViperPresenter {
    var navTitle:String { get set }
    var fine: VehicleTrafficFineDubaiPolice { get set }
    var selectedItem:ListItems? {get set}
    var isSavedForFuture:Bool {get set}
    var plateSource:[VehicleLookup] { get }
    var plateCategories:[VehicleLookup] { get }
    var plateCodes:[VehicleLookup] { get }
    var licenseSource:[VehicleLookup] { get }
    var fineSource:[VehicleLookup] { get }
    func loadData()
    func navigateToTraficFineScreen(fineDetails:FinePayBillsResponse?)
    func reloadTextFields(_ type:VehicleFineType?)
    func validatePayBills()
    
}

protocol VehiclesAndTransportDetailInteractorProtocol: ViperInteractor {
    func getResourceList(_ listType:String)
    func getLookups(type:String,fieldText:String)
    func validate(serviceId:String,_ data:[[String:Any]])
}

protocol VehiclesAndTransportDetailInteractorOutputProtocol: AnyObject {
    func ongetResourceList(Response response: VehiclesAndTransportResourceModel?)
    func ongetResourceList(Error error: AppError)
    func ongetLookupList(Response response: VehiclesAndTransportLookupModel?,type:String)
    func ongetLookupList(Error error: AppError)
    func onValidatePayBill(Response response: VehiclesAndTransportValidateModel?)
    func onValidatePayBill(Error error: AppError)
    
}

protocol VehiclesAndTransportDetailRouterProtocol: ViperRouter {
    func go(to route: VehiclesAndTransportDetailRouter.Route)
}
