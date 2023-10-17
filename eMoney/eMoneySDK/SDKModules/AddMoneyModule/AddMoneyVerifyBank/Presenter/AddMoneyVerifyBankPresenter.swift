//
//  AddMoneyVerifyBankPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 27/04/2023.
//  
//

import Foundation

class AddMoneyVerifyBankPresenter {

    // MARK: Properties
    var dataSource: [StandardCellModel] = []
    var cellAction: StandardCellActions?
    
    weak var view: AddMoneyVerifyBankViewProtocol?
    var router: AddMoneyVerifyBankRouterProtocol?
    var interactor: AddMoneyVerifyBankInteractorProtocol?
    
    var bankLogo: String = ""
    var bankName: String = ""
    var verifyButtonTitle: String = Strings.AddMoney.verifyButtonText
    private var ibanString = ""
    private var ibanVerificationStatus: IBANTableViewCellModel.VerificationStatus = .normal
}


extension AddMoneyVerifyBankPresenter: AddMoneyVerifyBankPresenterProtocol {
    func loadData() {
        view?.setupUI()
        
        self.setupCellActions()
        self.makeDataSource()
    }
}

// MARK: - Prepare Data Source
extension AddMoneyVerifyBankPresenter {
    func makeDataSource() {
        dataSource.removeAll()
        
        let selectedBankModel = SelectedBankTableViewCellModel(logo: bankLogo, name: bankName)
        dataSource.append(selectedBankModel)
        
        let spaceCell = SpaceTableViewCellModel(height: 44)
        dataSource.append(spaceCell)
        
        let ibanModel = IBANTableViewCellModel(actions: cellAction, title: Strings.AddMoney.enterIbanToAddFunds, iban: ibanString, verificationStatus: ibanVerificationStatus)
        dataSource.append(ibanModel)
        
        view?.reloadData()
    }
    
    private func setupCellActions() {
        self.cellAction = StandardCellActions(cellSelected: { [weak self] (index, model) in
            guard let `self` = self else { return }
            if let model = model as? IBANTableViewCellModel {
                if index == 0 {
                    self.ibanString = model.iban
                    self.verifyButtonTitle = Strings.AddMoney.verifyButtonText
                    self.ibanVerificationStatus = .normal
                    self.view?.updateUI()
                } else {
                    self.showIbanInfoView()
                }
            }
        })
    }
}

// MARK: - Navigations
extension AddMoneyVerifyBankPresenter {
    private func showIbanInfoView() {
        var dataSource = [StandardCellModel]()
        
        let titleCell = GenericSingleLabelCellModel(content: Strings.AddMoney.determineYourIbanNumber, alignment: .center)
        dataSource.append(titleCell)
        
        let descriptionCellModel = SingleImageTableViewCellModel(image: "iban-info", backgroundImage: "iban-info-background")
        dataSource.append(descriptionCellModel)
        
        router?.go(to: .showIBANInfo(dataSource: dataSource))
    }
    
    func navigateToEnterAmountVC() {
        if ibanString.isEmpty {
            return
        }
//        interactor?.verifyIbanNumber(iban: ibanString)
        router?.go(to: .enterAmountVC(bankLogo: self.bankLogo, bankName: self.bankName))
    }
}

// MARK: - Interactor Output Protocol
extension AddMoneyVerifyBankPresenter: AddMoneyVerifyBankInteractorOutputProtocol {
    func onIbanVerification(response: BaseResponseModel?) {
        Loader.shared.hideFullScreen()
        
        self.ibanVerificationStatus = .verified
        self.verifyButtonTitle = Strings.AddMoney.continueButtonText
        self.makeDataSource()
        view?.updateUI()
    }
    
    func onIbanVerification(error: AppError) {
        Loader.shared.hideFullScreen()
        self.ibanVerificationStatus = .notVerified
        self.makeDataSource()
    }
}
