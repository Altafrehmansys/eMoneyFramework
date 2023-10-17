//
//  BillSelectPlanContainerViewPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 29/05/2023.
//  
//

import Foundation

class BillSelectPlanContainerViewPresenter {

    // MARK: Properties

    weak var view: BillSelectPlanContainerViewViewProtocol?
    var router: BillSelectPlanContainerViewRouterProtocol?
    var interactor: BillSelectPlanContainerViewInteractorProtocol?
    private var selectedProduct: Product?
    var input:BillAccountDetailsParameters? = nil
}

extension BillSelectPlanContainerViewPresenter: BillSelectPlanContainerViewPresenterProtocol {
    
    func loadData() {
        view?.updateUserData(number: input?.accountNumber ?? "", name: input?.title ?? "", imageURL: input?.selectedItem?.imageUrl ?? "")
        interactor?.getProducts(accountNumber: "920000000000", countryISO: "PK")
        if let name = input?.title, name.isEmpty {
            view?.hideNameLabel()
        }
    }
    
    func didSelectNextButton() {
        guard let input = input else { return }
        router?.go(to: .sendMoney(input: input) )
    }
    func didSelect(product: Product) {
        self.selectedProduct = product
        self.input?.billDueAmount = "\(product.sendCurrencyIso ?? "") \(product.sendAmount ?? "")"
        self.input?.enterBillAmount = "\(product.sendCurrencyIso ?? "") \(product.sendAmount ?? "")"
    }
    
    private func getTopupFrom(products: [Product]) {
        let filteredTopupProducts = products.filter({ $0.transferType == "TopUp" })
        self.view?.updateAirTimeview(data: filteredTopupProducts)
        
    }
    
    private func getDataFrom(products: [Product]) {
        let filteredDataProducts = products.filter({ $0.transferType == "Data" })
        self.view?.updateDataView(data: filteredDataProducts)
        
    }
    private func getBundlesFrom(products: [Product]) {
        let filteredBundlesProducts = products.filter({ $0.transferType == "Bundle" })
        self.view?.updateBundlesView(data: filteredBundlesProducts)
    }
}

extension BillSelectPlanContainerViewPresenter: BillSelectPlanContainerViewInteractorOutputProtocol {
    func getProductsSuccess(data: ProductsListData) {
        getTopupFrom(products: data.productList)
        getDataFrom(products: data.productList)
        getBundlesFrom(products: data.productList)
    }
    
    func getProductsFail(error: AppError) {
        
    }
    
}
