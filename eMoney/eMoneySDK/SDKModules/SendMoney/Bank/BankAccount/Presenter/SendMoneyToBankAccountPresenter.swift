//
//  SendMoneyToBankAccountPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation

class SendMoneyToBankAccountPresenter {

    // MARK: Properties

    weak var view: SendMoneyToBankAccountViewProtocol?
    var router: SendMoneyToBankAccountRouterProtocol?
    var interactor: SendMoneyToBankAccountInteractorProtocol?
  

}

extension SendMoneyToBankAccountPresenter: SendMoneyToBankAccountPresenterProtocol {
    func navigateToSendMoneyEnterAmount() {
        self.router?.go(to: .navigateToSendMoneyEnterAmount)
    }
    func loadData() {
    
    }
}

extension SendMoneyToBankAccountPresenter: SendMoneyToBankAccountInteractorOutputProtocol {
    
}

// MARK: - Navigations
extension SendMoneyToBankAccountPresenter {
    func showIbanInfoView() {
        var dataSource = [StandardCellModel]()
        let titleCell = GenericSingleLabelCellModel(content: "How to I find my IBAN Number?", alignment: .center)
        dataSource.append(titleCell)
        
        let titleCell2 = GenericSingleLabelCellModel(content: "You can find your IBAN in the Internet/Mobile Bank and on your account statement.It starts with AE and total length is 23 characters", alignment: .center)
        dataSource.append(titleCell2)
        
//        let descriptionCellModel = SingleImageTableViewCellModel(image: "iban-info", backgroundImage: "iban-info-background")
//        dataSource.append(descriptionCellModel)
        self.router?.go(to: .showIBANInfo(dataSource: dataSource))
    }
}

