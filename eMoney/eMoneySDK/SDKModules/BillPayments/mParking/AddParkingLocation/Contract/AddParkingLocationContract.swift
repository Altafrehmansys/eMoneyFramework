//
//  AddParkingLocationContract.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/06/2023.
//  
//

import Foundation

protocol AddParkingLocationViewProtocol: ViperView {
    func setupUI()
}

protocol AddParkingLocationPresenterProtocol: ViperPresenter {
    func loadData()
    func presentParkingDetails()
    func showDropDown(anchorView:StandardTextField)
}

protocol AddParkingLocationInteractorProtocol: ViperInteractor {
    
}

protocol AddParkingLocationInteractorOutputProtocol: AnyObject {
}

protocol AddParkingLocationRouterProtocol: ViperRouter {
    func go(to route: AddParkingLocationRouter.Route)
}
