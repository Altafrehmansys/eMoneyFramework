//
//  AgentsAndMachineContract.swift
//  e&money
//
//  Created by Qamar Iqbal on 04/05/2023.
//  
//

import Foundation
import CoreLocation

protocol AgentsAndMachineViewProtocol: ViperView {
    var presenter: AgentsAndMachinePresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
    func showChooseMapBottomSheetAlert(lat: Double, long: Double, destinationName: String)
}

protocol AgentsAndMachinePresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    var getLocationNearByType: String { get set }
    var totalPages: Int { get set }
    var coordinatesWithinRadius: [CLLocation] { get set }
    var locationsList: [AgentsAndMachineResponseModel.LocationsDataModel] { get set }

    func loadData()
    func loadPageData(pageNumber: Int, latitude: Double, longitude: Double)
    func makeDataSource()
    func updateDataSource(with state: FloatingPanelState)
}

protocol AgentsAndMachineInteractorProtocol: ViperInteractor {
    func getLocationsList(request: GetLocationListModel)
}

protocol AgentsAndMachineInteractorOutputProtocol: AnyObject {
    func onLocationsListResponse(response: AgentsAndMachineResponseModel?)
    func onFetchAgentsError(error : AppError)
}

protocol AgentsAndMachineRouterProtocol: ViperRouter {
    func go(to route: AgentsAndMachineRouter.Route)
}
