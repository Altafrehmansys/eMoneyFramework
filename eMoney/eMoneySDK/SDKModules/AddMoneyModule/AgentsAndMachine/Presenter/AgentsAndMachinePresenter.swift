//
//  AgentsAndMachinePresenter.swift
//  e&money
//
//  Created by Qamar Iqbal on 04/05/2023.
//  
//

import Foundation
import CoreLocation
import UIKit

class AgentsAndMachinePresenter {

    // MARK: Properties
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    weak var view: AgentsAndMachineViewProtocol?
    var router: AgentsAndMachineRouterProtocol?
    var interactor: AgentsAndMachineInteractorProtocol?
    
    var getLocationNearByType: String = ""
    var coordinatesWithinRadius: [CLLocation] = []
    var totalPages:Int = 0
    var locationsList: [AgentsAndMachineResponseModel.LocationsDataModel] = []
    
    private var state = FloatingPanelState.half
}

extension AgentsAndMachinePresenter: AgentsAndMachinePresenterProtocol {

    func loadData() {
        view?.setupUI()
        self.setupCellActions()
    }
    
    func loadPageData(pageNumber: Int, latitude: Double, longitude: Double) {
        Loader.shared.showFullScreen()
        let request = GetLocationListModel(latitude: latitude, longitude: longitude, locationType: getLocationNearByType, radius: nil, pageNumber: pageNumber)
        interactor?.getLocationsList(request: request)
    }
    
    func makeDataSource() {
        self.dataSource.removeAll()
        
        self.showNearByLocations()
        
        if getLocationNearByType == GetLocationsView.agentsView.rawValue {
            self.dataSource.insert(getMapTableViewCell(), at: 0)
        } else {
            self.updateDataSource(with: self.state)
        }
        
        view?.reloadData()
    }
    
    private func showNearByLocations() {
        self.locationsList.forEach { model in
            if let lat = model.latitude, let long = model.longitude {
                let coordinate = CLLocation(latitude: lat, longitude: long)
                let addData = NearByTableViewCellModel(actions: self.cellActions, dataModel: model)
                self.coordinatesWithinRadius.append(coordinate)
                self.dataSource.append(addData)
            }
        }
    }    
    
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    private func getMapTableViewCell() -> MapTableViewCellModel {
        let mapCellModel = MapTableViewCellModel(actions: self.cellActions, coordinates: self.coordinatesWithinRadius)
        return mapCellModel
    }
    
    func updateDataSource(with state: FloatingPanelState) {
        if getLocationNearByType == GetLocationsView.agentsView.rawValue {
            return
        }
        
        self.state = state
        
        if state == FloatingPanelState.half, let _ = self.dataSource[0] as? MapTableViewCellModel {
            self.dataSource.remove(at: 0)
        } else if state == FloatingPanelState.full {
            if let _ = self.dataSource[0] as? MapTableViewCellModel {
                return
            }
            self.dataSource.insert(getMapTableViewCell(), at: 0)
        }
        view?.reloadData()
    }
}

// MARK: - Setup Cells Actions
extension AgentsAndMachinePresenter {
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { [weak self] (index, model) in
            guard let `self` = self else { return }
            
            if let model = model as? MapTableViewCellModel {
                self.view?.showChooseMapBottomSheetAlert(lat: model.lat ?? 0.0, long: model.long ?? 0.0, destinationName: "")
                return
            }
            
            if let model = model as? NearByTableViewCellModel {
                let lat = model.dataModel.latitude ?? 0.0
                let long = model.dataModel.longitude ?? 0.0
                self.view?.showChooseMapBottomSheetAlert(lat: lat, long: long, destinationName: model.dataModel.addressShort ?? "")
            }
        })
    }
}

// MARK: - Responses
extension AgentsAndMachinePresenter: AgentsAndMachineInteractorOutputProtocol {
    func onLocationsListResponse(response: AgentsAndMachineResponseModel?) {
        Loader.shared.hideFullScreen()
        if let response, let locationList = response.data?.locations, let totalPages = response.data?.totalPages {
            self.locationsList.append(contentsOf: locationList)
            self.totalPages = totalPages
            self.makeDataSource()
        }
    }
    
    func onFetchAgentsError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription)
    }
}
