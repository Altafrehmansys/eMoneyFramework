//
//  VehiclesAndTransportDetailPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation

enum VehicleFineType:String{
    case plateNo = "Plate number"
    case tfcNo = "TFC number"
    case licenseNo = "License number"
    case fineNo = "Fine number"
    var serviceId:String {
        switch self {
        case .plateNo:return "248"
        case .tfcNo:return "249"
        case .licenseNo:return "250"
        case .fineNo:return "251"
        }
    }
}
struct VehicleTrafficFineDubaiPolice {
    var plateNumber = PlateNumberInfo()
    var tfcNumber = TFCNumnerInfo()
    var licenseNumber = LicenseNumberInfo()
    var fineNumber = FineNumberInfo()
    var selectedType:VehicleFineType = .plateNo
    var fineDetails:FinePayBillsResponse? = nil
    struct FineNumberInfo {
        var selectedItem:String?
        var fineSource:String?
        var licenseNumber:String?
        var fineYear:String?
        var fineNumber:String?
        var request:[[String:Any]] {
            return [
                ["key":"fine_source","value":/self.fineSource],
                ["key":"fine_year","value":/self.fineYear],
                ["key":"fine_number","value":/self.fineNumber]
//                ["key":"license_number","value":/self.licenseNumber]
            ]
        }
        var title:String {
            return "\(self.fineSource ?? "") \(self.fineNumber ?? "")"
        }
        init(){}
    }
    struct LicenseNumberInfo {
        var selectedItem:String?
        var licenseSource:String?
        var licenseNumber:String?
        var request:[[String:Any]] {
            return [
                ["key":"license_source","value":/self.licenseSource],
                ["key":"license_number","value":/self.licenseNumber]
            ]
        }
        var title:String {
            return "\(self.licenseSource ?? "") \(self.licenseNumber ?? "")"
        }
        init(){}
    }
    struct TFCNumnerInfo {
        var selectedItem:String?
        var tfcNumber:String?
        var request:[[String:Any]] {
            return [
                ["key":"tfc_number","value":/self.tfcNumber]
            ]
        }
        var title:String {
            return "\(self.tfcNumber ?? "")"
        }
        init(){}
    }
    struct PlateNumberInfo {
        var selectedItem:String?
        var plateSource:String?
        var plateCategory:String?
        var plateCode:String?
        var plateNumber:String?
        var request:[[String:Any]] {
            return [
                ["key":"plate_source","value":/self.plateSource],
                ["key":"plate_category","value":/self.plateCategory],
                ["key":"plate_code","value":/self.plateCode],
                ["key":"plate_number","value":/self.plateNumber]
            ]
        }
        var title:String {
            return "\(self.plateSource ?? "") \(self.plateNumber ?? "")"
        }
        init(){}
    }
}

class VehiclesAndTransportDetailPresenter {
    
    // MARK: Properties
    
    weak var view: VehiclesAndTransportDetailViewProtocol?
    var router: VehiclesAndTransportDetailRouterProtocol?
    var interactor: VehiclesAndTransportDetailInteractorProtocol?
    var navTitle: String = ""
    var selectedItem: ListItems? = nil
    var selectItemType:VehicleFineType = .plateNo
    var billType:BillsAnsTopUpType = .none
    var isSavedForFuture = true
    
    var fine = VehicleTrafficFineDubaiPolice()
    var vehicleResponseModel: VehiclesAndTransportResourceModel? = nil
    
    var plateSource:[VehicleLookup] = []
    var plateCategories:[VehicleLookup] = []
    var plateCodes:[VehicleLookup] = []
    var licenseSource:[VehicleLookup] = []
    var fineSource:[VehicleLookup] = []
}

extension VehiclesAndTransportDetailPresenter: VehiclesAndTransportDetailPresenterProtocol {
    func validatePayBills() {
        Loader.shared.showFullScreen()
        switch self.fine.selectedType {
        case .plateNo:
            self.interactor?.validate(serviceId: self.fine.selectedType.serviceId, self.fine.plateNumber.request)
        case .tfcNo:
            self.interactor?.validate(serviceId:self.fine.selectedType.serviceId, self.fine.tfcNumber.request)
        case .licenseNo:
            self.interactor?.validate(serviceId: self.fine.selectedType.serviceId, self.fine.licenseNumber.request)
        case .fineNo:
            self.interactor?.validate(serviceId: self.fine.selectedType.serviceId, self.fine.fineNumber.request)
        }
    }
    func loadSelectedItemData() {
        Loader.shared.showFullScreen()
        switch self.fine.selectedType {
        case .plateNo:
            self.interactor?.getLookups(type: "DP_PLATE_SOURCE", fieldText: "")
            self.interactor?.getLookups(type: "DP_PLATE_CATEGORY", fieldText: "")
            self.interactor?.getLookups(type: "DP_PLATE_CODE", fieldText: "")
        case .tfcNo:break
        case .licenseNo:
            self.interactor?.getLookups(type: "DP_LICENSE_SOURCE", fieldText: "")
        case .fineNo:
            self.interactor?.getLookups(type: "DP_FINE_SOURCE", fieldText: "")
        }
    }
    func navigateToTraficFineScreen(fineDetails:FinePayBillsResponse?) {
        let input = BillAccountDetailsParameters(billTitle: nil,
                                                 billSubTitle: nil,
                                                 isSavedBill: self.isSavedForFuture,
                                                 billType: .vehicleTrafficFineDubaiPolice,
                                                 selectedItem: self.selectedItem,
                                                 billDueAmount: nil,
                                                 enterBillAmount: nil,
                                                 traficFineDubaiPolice: self.fine,
                                                 billMin: "1",
                                                 billMax: "5000",
                                                 transactionId: /fineDetails?.transactionID,
                                                 accountNumber: nil,
                                                 denominations: nil,
                                                 pin: nil)
        self.router?.go(to: .fineDetails(input:input,fineDetails: fineDetails))
    }
    
    func loadData() {
        view?.setupUI()
        view?.setTextFields(.none)
        Loader.shared.showFullScreen()
        self.interactor?.getResourceList("dubaiPolice")
    }
    func reloadTextFields(_ type: VehicleFineType?) {
        self.fine.selectedType = type ?? .plateNo
        self.loadSelectedItemData()
        view?.setTextFields(type)
    }
}

extension VehiclesAndTransportDetailPresenter: VehiclesAndTransportDetailInteractorOutputProtocol {
    
    func ongetResourceList(Response response: VehiclesAndTransportResourceModel?) {
        Loader.shared.hideFullScreen()
        self.vehicleResponseModel = response
    }
    
    func ongetResourceList(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.errorDescription)
    }
    func ongetLookupList(Response response: VehiclesAndTransportLookupModel?,type:String) {
        Loader.shared.hideFullScreen()
        var data = response?.data
        data?.removeFirst()
        switch type {
        case "DP_PLATE_SOURCE": self.plateSource = data ?? []
        case "DP_PLATE_CATEGORY": self.plateCategories = data ?? []
        case "DP_PLATE_CODE": self.plateCodes = data ?? []
        case "DP_LICENSE_SOURCE": self.licenseSource = data ?? []
        case "DP_FINE_SOURCE": self.fineSource = data ?? []
        default:break
        }
    }
    func ongetLookupList(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.errorDescription)
    }
    func onValidatePayBill(Response response: VehiclesAndTransportValidateModel?) {
        Loader.shared.hideFullScreen()
        self.navigateToTraficFineScreen(fineDetails: response?.data)
    }
    func onValidatePayBill(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.errorDescription)
    }
}
