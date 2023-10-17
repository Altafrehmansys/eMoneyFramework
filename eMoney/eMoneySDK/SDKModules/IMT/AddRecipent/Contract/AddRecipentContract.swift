//
//  AddRecipentContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

protocol AddRecipentViewProtocol: ViperView {
   
    func setupUI()
    func reloadData()
}

protocol AddRecipentPresenterProtocol: ViperPresenter {
    
    var dataSource: [StandardCellModel] { get }
    
    func viewDidLoad()
    func makeDataSource()
    func navigateToSummary()
   
    
}

protocol AddRecipentInteractorProtocol: ViperInteractor {
    
}

protocol AddRecipentInteractorOutputProtocol: AnyObject {
}

protocol AddRecipentRouterProtocol: ViperRouter {
    func go(to route: AddRecipentRouter.Route)
}
