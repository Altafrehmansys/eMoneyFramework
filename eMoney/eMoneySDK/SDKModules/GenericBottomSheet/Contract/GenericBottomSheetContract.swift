//
//  GenericBottomSheetContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//  
//

import Foundation

protocol GenericBottomSheetViewProtocol: ViperView {
    var presenter: GenericBottomSheetPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
}

protocol GenericBottomSheetPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel]? { get }
    var actions: [BaseButton]? { get }
    
    func loadData()
    func dismissView()
}

protocol GenericBottomSheetInteractorProtocol: ViperInteractor {
    
}

protocol GenericBottomSheetInteractorOutputProtocol: AnyObject {
}

protocol GenericBottomSheetRouterProtocol: ViperRouter {
    func go(to route: GenericBottomSheetRouter.Route)
}
