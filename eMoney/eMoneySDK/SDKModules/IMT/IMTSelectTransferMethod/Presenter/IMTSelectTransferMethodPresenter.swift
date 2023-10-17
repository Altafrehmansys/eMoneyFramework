//
//  IMTSelectTransferMethodPresenter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 30/05/2023.
//  
//

import Foundation

class IMTSelectTransferMethodPresenter:IMTSelectTransferMethodPresenterProtocol {

    // MARK: Properties

    weak var view: IMTSelectTransferMethodViewProtocol?
    var router: IMTSelectTransferMethodRouterProtocol?
    var interactor: IMTSelectTransferMethodInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellAction: StandardCellActions?
    
    func loadData() {
    makeDataSource()
    }
}

extension IMTSelectTransferMethodPresenter {
    
    func makeDataSource() {
        for _ in 0...2 {
            let model = IMTTransferMethodCellModel(actions: cellAction, title: "Bank Account", subtitle: "1 AED", image: "")
            dataSource.append(model)
        }
        
        view?.reloadData()
    }
    
    private func setupCellActions() {
        cellAction = StandardCellActions {[weak self] index, model in
//            if let cellModel = model as? RegisterOptionCellModel {
//                switch cellModel.type {
//                case .emiratesId:
//                    print("Smart card id tapped")
//                    self?.router.go(to: .captureIdentity)
//                case .uaePass:
//                    print("UAE pass tapped")
//                }
//            }
        }
    }
}

extension IMTSelectTransferMethodPresenter: IMTSelectTransferMethodInteractorOutputProtocol {
    
}
