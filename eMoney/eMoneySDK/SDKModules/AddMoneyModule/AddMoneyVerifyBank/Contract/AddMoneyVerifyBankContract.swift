//
//  AddMoneyVerifyBankContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 27/04/2023.
//  
//

import Foundation

protocol AddMoneyVerifyBankViewProtocol: ViperView {
    var presenter: AddMoneyVerifyBankPresenterProtocol! { get set }
    
    func setupUI()
    func updateUI()
    func reloadData()
}

protocol AddMoneyVerifyBankPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    var bankLogo: String { get set }
    var bankName: String { get set }
    var verifyButtonTitle: String { get set }
    
    func loadData()
    func makeDataSource()
    
    func navigateToEnterAmountVC()
}

protocol AddMoneyVerifyBankInteractorProtocol: ViperInteractor {
    func verifyIbanNumber(iban: String)
}

protocol AddMoneyVerifyBankInteractorOutputProtocol: AnyObject {
    func onIbanVerification(response: BaseResponseModel?)
    func onIbanVerification(error: AppError)
}

protocol AddMoneyVerifyBankRouterProtocol: ViperRouter {
    func go(to route: AddMoneyVerifyBankRouter.Route)
}
