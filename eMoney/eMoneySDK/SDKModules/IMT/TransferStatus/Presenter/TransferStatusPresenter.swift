//
//  TransferStatusPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

class TransferStatusPresenter {

    // MARK: Properties

    weak var view: TransferStatusViewProtocol?
    var router: TransferStatusRouterProtocol?
    var interactor: TransferStatusInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellAction: StandardCellActions?
    func viewDidLoad() {
        view?.setupUI()
        setupCellActions()
        makeDataSource()
    }
}

extension TransferStatusPresenter: TransferStatusPresenterProtocol {
    func makeDataSource() {
        let labelCellModel1 = RecipentDetailsTableViewCellModel(name:"Abdullah Mansoor", bankName:
                                                                    "HDFC bank, Mumbai, India", iban: "IBAN AB 00 ABCD 123456 789111", imageUrl: "")
        dataSource.append(labelCellModel1)
        let cellModel =  TransferProcessingTableViewCellModel(status: "Completed", recipentTime: "Usually occurs the same day you sent the transfer", time: "2 hours", day: "Can take up to 1 day", processingDesc: "ETA based on recipient’s bank processing")
        dataSource.append(cellModel)
        view?.reloadData()
    }
    
    private func setupCellActions() {
        cellAction = StandardCellActions {[weak self] index, model in
            if let cellModel = model as? SummaryHeadingTableViewCellModel {
            print(" SummaryHeadingTableViewCellModel tapped")
            }
        }
    }
}

extension TransferStatusPresenter: TransferStatusInteractorOutputProtocol {
    
}
