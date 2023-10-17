//
//  AddMobileBillAccountContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 22/05/2023.
//  
//

import Foundation

protocol AddMobileBillAccountViewProtocol: ViperView {
    func setupUI()
}

protocol AddMobileBillAccountPresenterProtocol: ViperPresenter {
    
    func loadData()
    func showIdentityVerificationBottomSheet()
    func navigateToMobileBillEnterAmountScreen()

  
}

protocol AddMobileBillAccountInteractorProtocol: ViperInteractor {
    
}

protocol AddMobileBillAccountInteractorOutputProtocol: AnyObject {
}

protocol AddMobileBillAccountRouterProtocol: ViperRouter {
    func go(to route: AddMobileBillAccountRouter.Route)
}
