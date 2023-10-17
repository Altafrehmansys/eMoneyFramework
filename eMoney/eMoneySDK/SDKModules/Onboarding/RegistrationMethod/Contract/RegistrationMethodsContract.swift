//
//  RegistrationMethodsContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import Foundation

// MARK: - Router
protocol RegistrationMethodsRouterProtocol: AnyObject {
    func go(to route: RegistrationMethodsRouter.Route)
}

// MARK: - Interactor
protocol RegistrationMethodsInteractorProtocol: AnyObject {
    func lookupApiCalltoServer(lookupType: String)
}

protocol RegistrationMethodsInteractorOutputProtocol: AnyObject {
    func lookupApiCallError(error: AppError)
    func lookupApiCallResponse(response: LookupRegistrationMethodsModel?)
}

// MARK: - Presenter
protocol RegistrationMethodsPresenterProtocol: AnyObject {
    var dataSource: [StandardCellModel] { get }
    
    init(view: RegistrationMethodsViewProtocol,
         interactor: RegistrationMethodsInteractorProtocol,
         router: RegistrationMethodsRouterProtocol)
    
    func viewDidLoad()
    func makeDataSource(data:[LookupRegistrationData])
    func navigateToEnterEmail()
    func lookupRequestToServer(lookupType : String)
}

// MARK: - View
protocol RegistrationMethodsViewProtocol: AnyObject {
    
    var presenter: RegistrationMethodsPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
}
