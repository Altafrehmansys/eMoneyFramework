//
//  GenericBottomSheetPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//  
//

import Foundation

class GenericBottomSheetPresenter {

    // MARK: Properties
    weak var view: GenericBottomSheetViewProtocol?
    var router: GenericBottomSheetRouterProtocol?
    var interactor: GenericBottomSheetInteractorProtocol?
    
    var dataSource: [StandardCellModel]?
    var actions: [BaseButton]?
}

extension GenericBottomSheetPresenter: GenericBottomSheetPresenterProtocol {
    func loadData() {
        view?.setupUI()
        view?.reloadData()
    }
}

// MARK: - Navigations Calls
extension GenericBottomSheetPresenter {
    func dismissView() {
        router?.go(to: .back)
    }
}

extension GenericBottomSheetPresenter: GenericBottomSheetInteractorOutputProtocol {
    
}
