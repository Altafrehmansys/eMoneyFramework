//
//  SelectProviderViewPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//  
//

import Foundation

class SelectProviderViewPresenter {

    // MARK: Properties

    weak var view: SelectProviderViewProtocol?
    var router: SelectProviderViewRouterProtocol?
    var interactor: SelectProviderViewInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    weak var delegate: SelectProviderViewDelegate?
    private var countryISO: String
    
    init(countryISO: String) {
        self.countryISO = countryISO
    }
}

extension SelectProviderViewPresenter: SelectProviderViewPresenterProtocol {
    
    func loadData() {
        Task {
            await interactor?.getNetworkProviders(countryCode: self.countryISO)
        }
    }
    
    func didSelectProvider(index: Int) {
        let provider = dataSource[index]
        guard let provider = provider as? ProviderCellModel  else { return }
        delegate?.didSelectProvider(provider: provider)
        router?.go(to: .dimiss)
    }
    
    private func getDatasurce(data: [NetworkProviderData]) {
        var datasource = [StandardCellModel]()
        datasource = data.map({  return ProviderCellModel(name: $0.providerName ?? "", image: $0.logoUrl ?? "") })
        self.dataSource = datasource
    }
}

extension SelectProviderViewPresenter: SelectProviderViewInteractorOutputProtocol {
    func getProvidersSuccess(data: NetworkProvidersResponse) {
        getDatasurce(data: data.data)
        view?.reloadData()
    }
    
    func getProvidersFail(error: Error) {
        
    }
    
    
}
