//
//  BillSelectPlanContainerViewContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 29/05/2023.
//  
//

import Foundation

protocol BillSelectPlanContainerViewViewProtocol: ViperView {
    func updateUserData(number: String, name: String, imageURL: String)
    func updateAirTimeview(data: [Product])
    func updateDataView(data: [Product])
    func updateBundlesView(data: [Product])
    func hideNameLabel()
}

protocol BillSelectPlanContainerViewPresenterProtocol: ViperPresenter {
    func loadData()
    func didSelectNextButton()
    func didSelect(product: Product)
}

protocol BillSelectPlanContainerViewInteractorProtocol: ViperInteractor {
    func getProducts(accountNumber: String, countryISO: String)
}

protocol BillSelectPlanContainerViewInteractorOutputProtocol: AnyObject {
    func getProductsSuccess(data: ProductsListData)
    func getProductsFail(error: AppError)
}

protocol BillSelectPlanContainerViewRouterProtocol: ViperRouter {
    func go(to route: BillSelectPlanContainerViewRouter.Route)
}
