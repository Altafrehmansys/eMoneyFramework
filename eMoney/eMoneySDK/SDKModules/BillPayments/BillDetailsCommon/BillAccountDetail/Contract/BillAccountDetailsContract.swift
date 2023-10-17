//
//  BillAccountDetailsContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//  
//

import Foundation

protocol BillAccountDetailsViewProtocol: ViperView {
    
    var presenter: BillAccountDetailsPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
    func provider(image: String, name: String)
    func showAccountNumberTextFieldView(placeholder: String, type: StandardTextField.EntryType, trailingIcon: String?, prefix:String?,limit:Int?)
    func showNicknameTextFieldView(placeholder: String)
    func showFullnameTextFieldView(placeholder: String)
    func showAddressTextFieldView(placeholder: String)
    func showPinNumberTextFieldView(placeholder: String)
    func showMawakefSelectServiceView()
    func showAccountTypeView()

    
    func hideFullNameView()
    func hideAddressView()
    func hideAccountNumberView()
    func hideNicknameView()
    func hidePinNumberView()
    func hideMawakefView()
    func hideAccountTypeView()
    func updateCountryCode(code: String)
    
    func showAccountNumberError(message: String)
    func showPinNumberError(message: String)
    func showNicknameError(message: String)
    
  
  
}

protocol BillAccountDetailsPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    var viewData: BillAccountDetailsViewData { get set }
    func loadData()
    func accountNumberTrailingBtnDidTapped()
    func accountNumberLeadingBtnDidTapped() 
    func updatePhoneNumberTextField(phoneNumber: String)
    func makeDataSource()
    func addNewAccount()
    func navigateToEnterAmountScreen()
    func loadForgotPINBottomSheet()
    
    func set(accountNumber: String)
    func set(nickname: String)
    func set(pinNumber: String)
    
    var isPrepaidSelected:Bool {get set}
    var isMawaqifTopupSelected:Bool {get set}
    
}

protocol BillAccountDetailsInteractorProtocol: ViperInteractor {
    func validate(msisdn: String, accountNumber: String, serviceId: String, pinNumber: String?)
}

protocol BillAccountDetailsInteractorOutputProtocol: AnyObject {
    func validatePhoneNumberSuccess(data: ValidatePayBillResponse)
    func validatePhoneNumberFail(error: AppError)
}

protocol BillAccountDetailsRouterProtocol: ViperRouter {
    func go(to route: BillAccountDetailsRouter.Route)
}
