//
//  BillSelectProviderRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//  
//

import UIKit

class BillSelectProviderRouter {

    enum Route {
        case selectCountry(delegate: SelectCountryViewDelegate?)
        case selectProvider(countryISO: String, delegate: SelectProviderViewDelegate?)
        case next(data: BillAccountDetailsViewData)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(navTitle:String,selecteItem:ListItems?,billType:BillsAnsTopUpType) -> BillSelectProviderViewController {
        let viewController = BillSelectProviderViewController()
        let presenter = BillSelectProviderPresenter()
        let router = BillSelectProviderRouter()
        let interactor = BillSelectProviderInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.navTitle = navTitle
        presenter.selectedItem = selecteItem
        presenter.selectItemType = billType
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension BillSelectProviderRouter: BillSelectProviderRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case let .selectCountry(delegate):
            navigateToCountriesList(delegate: delegate)
        case let .selectProvider(countryISO, delegate):
            navigateToProvidersList(countryISO: countryISO, delegate: delegate)
        case let .next(data):
            navigateToBillsAccountDetails(data: data)
        }
    }
    
    
    private func navigateToCountriesList(delegate: SelectCountryViewDelegate?) {
        let selectCountryView = SelectCountryViewRouter.setupModule(delegate: delegate)
        self.view?.present(selectCountryView, animated: true)
    }
    
    private func navigateToProvidersList(countryISO: String, delegate: SelectProviderViewDelegate?) {
        let selectProviderView = SelectProviderViewRouter.setupModule(countryISO: countryISO, delegate: delegate)
        self.view?.present(selectProviderView, animated: true)
    }
    
    private func navigateToBillsAccountDetails(data: BillAccountDetailsViewData) {
        let accountDetailsView = BillAccountDetailsRouter.setupModule(navTitle: data.navTitle, selecteItem: data.selectedItem, billType: data.selectItemType, codeList: data.countryCodesList)
        self.view?.navigationController?.pushViewController(accountDetailsView, animated: true)
    }

}
