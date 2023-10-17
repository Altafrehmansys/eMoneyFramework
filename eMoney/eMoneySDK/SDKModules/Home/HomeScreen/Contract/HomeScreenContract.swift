//
//  HomeScreenContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import Foundation

// MARK: - Router
protocol HomeScreenRouterProtocol: AnyObject {
    func go(to route: HomeScreenRouter.Route)
}

// MARK: - Interactor
protocol HomeScreenInteractorProtocol: AnyObject {
    func getAvailableBalance()
}

protocol HomeScreenInteractorOutputProtocol: AnyObject {
    func onAvailableBalanceResponse(response: AvailableBalanceResponse?)
    func onAvailableBalanceError(error: AppError)
}

// MARK: - Presenter
protocol HomeScreenPresenterProtocol: AnyObject {
    
    var dataSource: [StandardCellModel] { get }
    
    init(view: HomeScreenViewProtocol,
         interactor: HomeScreenInteractorProtocol,
         router: HomeScreenRouterProtocol)
    
    func viewDidLoad()
    func makeDataSource()
    
    func navigateToSendMoney()
    func getAvailableBalance()
    func navigateToBillsAndTopsUp()
    func navigateToAddMoney()
}

// MARK: - View
protocol HomeScreenViewProtocol: AnyObject {
    var presenter: HomeScreenPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
}
