//
//  HomeScreenRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import UIKit

final class HomeScreenRouter: HomeScreenRouterProtocol {
    enum Route {
        case back
        case addMoney
        case sendMoney
        case BillsAndTopsUp
        case showAMLUnverifiedScreen
    }
    
    // MARK: - Attributes
    weak var viewController: UIViewController?
    
    @objc class func setupModule() -> HomeViewController {
        
        let viewController = HomeViewController()
        let router = HomeScreenRouter()
        let interactor = HomeScreenInteractor()
        let presenter = HomeScreenPresenter(view: viewController, interactor: interactor, router: router)
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.viewController = viewController
        interactor.output = presenter
        return viewController
    }
}

// MARK: - Navigation Methods
extension HomeScreenRouter {
    
    func go(to route: Route) {
        switch route {
        case .back:
            self.viewController?.navigationController?.popViewController(animated: true)
            
        case .addMoney:
            let vc = AddMoneyRouter.setupModule()
            let navigation = BaseNavigationController(rootViewController: vc)
            navigation.modalPresentationStyle = .overCurrentContext
            self.viewController?.tabBarController?.present(navigation, animated: true)
            
        case .sendMoney:
            let vc = SendMoneyRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        case .BillsAndTopsUp:
//            let vc = BillsAndTopsUpRouter.setupModule(isSavedBill: false)
//            vc.hidesBottomBarWhenPushed = true
//            self.viewController?.navigationController?.pushViewController(vc, animated: true)
            break
        case .showAMLUnverifiedScreen:
            let vc = ThankyouRouter.setupModule()
            vc.screenTypeEnum = .amlUnverifiedSupport
            vc.modalPresentationStyle = .overCurrentContext
            self.viewController?.tabBarController?.present(vc, animated: true)
        }
    }
}
