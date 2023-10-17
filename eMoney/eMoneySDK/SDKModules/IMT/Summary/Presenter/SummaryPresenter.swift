//
//  SummaryPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class SummaryPresenter {

    // MARK: Properties

    weak var view: SummaryViewProtocol?
    var router: SummaryRouterProtocol?
    var interactor: SummaryInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellAction: StandardCellActions?
    
//    required init(view: SummaryViewProtocol, interactor: SummaryInteractorProtocol, router: SummaryRouterProtocol) {
//        self.view = view
//        self.interactor = interactor
//        self.router = router
//    }
    
    func viewDidLoad() {
        view?.setupUI()
        setupCellActions()
        makeDataSource()
    }
    
}

extension SummaryPresenter: SummaryPresenterProtocol {
   
    func showFraudWarnings() {
        router?.go(to: .FraudWarning)
    }
    func showSenderDetails() {
        router?.go(to: .senderDetails)
    }
    func navigateToOtpOnConfirmTapped() {
        router?.go(to: .otpImt)
    }
    func navigateToSuccessTransfer() {
        router?.go(to: .successTransfer)
    }
    
}
// MARK: - Prepare Datasource
extension SummaryPresenter {
    func makeDataSource() {
        
        let labelCellModel = SummaryHeadingTableViewCellModel(actions: cellAction, title: "Recipient details")
        dataSource.append(labelCellModel)
        let labelCellModel1 = RecipentDetailsTableViewCellModel(name:"Abdullah Mansoor", bankName:
                                                                    "HDFC bank, Mumbai, India", iban: "IBAN AB 00 ABCD 123456 789111", imageUrl: "")
        dataSource.append(labelCellModel1)
        let labelCellModel2 = SummaryHeadingTableViewCellModel(actions: cellAction, title: "Transfer details")
        dataSource.append(labelCellModel2)
        let labelCellModel3 = TransferDetailsTableViewCellModel(deliveryMethod: "Bank account", recieveAmount: "INR 111,212.31", convertedAmount: "AED 1.00 = INR 22.51", sendAmount: "AED 5,000.00", fees: "AED 10.00", totalPayment: "AED 5,000.00", hasPromo: true)
        dataSource.append(labelCellModel3)
        
        
        let labelCellModel4 = SummaryDetailTableViewCellModel(actions: cellAction ,title: "Complete sender details", desc: "We need some additional details for your first transfer", imageUrl: "")
        dataSource.append(labelCellModel4)
        
        
        let labelCellModel5 = SummaryWarningTableViewCellModel(actions: cellAction ,desc: "Learn about fraud warnings to look out for when sending money abroad", imageUrl: "")
        dataSource.append(labelCellModel5)
        
        view?.reloadData()
    }
    
    private func setupCellActions() {
        cellAction = StandardCellActions {[weak self] index, model in
            if let cellModel = model as? SummaryHeadingTableViewCellModel {
            print(" SummaryHeadingTableViewCellModel tapped")
            }
            if let cellModel = model as? SummaryDetailTableViewCellModel {
                self?.showSenderDetails()
            }
            if let cellModel = model as? SummaryWarningTableViewCellModel {
                self?.showFraudWarnings()
            }
        }
    }
    
   
}

extension SummaryPresenter: SummaryInteractorOutputProtocol {
    
}
