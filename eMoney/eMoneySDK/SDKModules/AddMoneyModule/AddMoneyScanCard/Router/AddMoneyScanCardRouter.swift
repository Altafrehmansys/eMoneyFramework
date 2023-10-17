//
//  AddMoneyScanCardRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 07/05/2023.
//  
//

import Foundation
import UIKit

class AddMoneyScanCardRouter {

    enum Route {
        case didReturn(cardDetails: CardDetails)
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?
    var delegate: AddMoneyScanCardRouterOutputProtocol?
    
    // MARK: Static methods

    static func setupModule(with delegate: UIViewController) -> AddMoneyScanCardViewController {
        let viewController = AddMoneyScanCardViewController.instantiate(fromAppStoryboard: .AddMoneyScanCard)
        let presenter = AddMoneyScanCardPresenter()
        let router = AddMoneyScanCardRouter()
        let interactor = AddMoneyScanCardInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController
        router.delegate = delegate as? AddMoneyScanCardRouterOutputProtocol

        interactor.output = presenter

        return viewController
    }
}

extension AddMoneyScanCardRouter: AddMoneyScanCardRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .didReturn(let cardDetails):
            self.view?.navigationController?.popViewController(animated: true)
            self.delegate?.didReturnCardData(cardDetails)
        case .tempCaseWithValue(let value):
            break
        }
    }
}
