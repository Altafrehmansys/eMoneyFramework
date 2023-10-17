//
//  BillSelectProviderPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//  
//

import Foundation

class BillSelectProviderPresenter {
    
    // MARK: Properties
    
    weak var view: BillSelectProviderViewProtocol?
    var router: BillSelectProviderRouterProtocol?
    var interactor: BillSelectProviderInteractorProtocol?
    
    var navTitle: String = ""
    var selectedItem: ListItems? = nil
    var selectItemType: BillsAnsTopUpType = .none
    var selectedCountry: CountryCellModel?
    var selectedProvider: ProviderCellModel?
    

}

extension BillSelectProviderPresenter: BillSelectProviderPresenterProtocol {
    
    func loadData() {
        view?.setUI()
        
    }
    
    func didTapSelectCountry() {
        router?.go(to: .selectCountry(delegate: self))
    }
    
    func didTapSelectProvider() {
        router?.go(to: .selectProvider(countryISO: selectedCountry?.iso ?? "", delegate: self))
    }
    
    func didTapNextButton() {
        let viewData = BillAccountDetailsViewData(navTitle: "", selectedItem: self.selectedItem, selectItemType: self.selectItemType, countryCodesList: selectedCountry?.codes)
        router?.go(to: .next(data: viewData))
    }
}

extension BillSelectProviderPresenter: BillSelectProviderInteractorOutputProtocol {
    
}

extension BillSelectProviderPresenter: SelectCountryViewDelegate {
    func didSelectCountry(country: CountryCellModel) {
        self.selectedCountry = country
        selectedProvider = nil
        view?.updateProvider(name: "")
        view?.disableNextButton()
        view?.updateCountry(name: country.name)
        if selectedCountry != nil && selectedProvider != nil {
            self.view?.enableNextButton()
        }
    }
    
}
extension BillSelectProviderPresenter: SelectProviderViewDelegate {
    func didSelectProvider(provider: ProviderCellModel) {
        self.selectedProvider = provider
        view?.updateProvider(name: provider.name)
        selectedItem?.title = provider.name
        if selectedCountry != nil && selectedProvider != nil {
            self.view?.enableNextButton()
        }
    }
    
}
