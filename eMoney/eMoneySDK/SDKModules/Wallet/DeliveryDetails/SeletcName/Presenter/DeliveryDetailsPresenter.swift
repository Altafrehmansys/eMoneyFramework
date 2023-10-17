//
//  DeliveryDetailsPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation

class DeliveryDetailsPresenter {

    // MARK: Properties

    weak var view: DeliveryDetailsViewProtocol?
    var router: DeliveryDetailsRouterProtocol?
    var interactor: DeliveryDetailsInteractorProtocol?
    var dataSource: [StandardCellModel] = []

}

extension DeliveryDetailsPresenter: DeliveryDetailsPresenterProtocol {
    
    func loadData() {
        setNames()
    }
    
    private func setNames() {
        for _ in 0..<5 {
            let data = ChooseNameCellModel(selected: false, name: "Mohamed")
            self.dataSource.append(data)
        }
        view?.reloadData()
    }
    
    func didSelectName(index: Int) {
        for (i, data) in dataSource.enumerated() {
            if let item = data as? ChooseNameCellModel {
                if i == index {
                    item.selected = true
                } else {
                    item.selected = false
                }
            }
        }
        view?.reloadData()
    }
    
    func confirmButtonDidTapped() {
        router?.go(to: .addAddress)
    }
}

extension DeliveryDetailsPresenter: DeliveryDetailsInteractorOutputProtocol {
    
}
