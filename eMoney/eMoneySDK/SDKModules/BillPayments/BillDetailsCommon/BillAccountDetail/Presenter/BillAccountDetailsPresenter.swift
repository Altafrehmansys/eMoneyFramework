//
//  BillAccountDetailsPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//  
//

import Foundation
import UIKit

class BillAccountDetailsPresenter {
    
    // MARK: Properties
    weak var view: BillAccountDetailsViewProtocol?
    var router: BillAccountDetailsRouterProtocol?
    var interactor: BillAccountDetailsInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var viewData: BillAccountDetailsViewData
    var isPrepaidSelected:Bool = true
    var isMawaqifTopupSelected:Bool = false
    var input:BillAccountDetailsParameters? = nil
    init(viewData: BillAccountDetailsViewData) {
        self.viewData = viewData
        
    }
}

extension BillAccountDetailsPresenter: BillAccountDetailsPresenterProtocol {
    
    func loadForgotPINBottomSheet() {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.forgotAccountOrPIN,font: AppFont.appRegular(size: .body2),color: AppColor.eAnd_Black_80,alignment: .center))
        dataSource.append(GenericSingleLabelCellModel(content: "Be ready with your license plate details.",font: AppFont.appRegular(size: .body3),color: AppColor.eAnd_Grey_100,alignment:.center))
       
        dataSource.append(GenericLabelWithLeftRightImageCellModel(actions: self.cellActions,leftImage:"web-icon", title: "Retrieve from Salik website"))
        
        dataSource.append(dividerCell())
        dataSource.append(GenericLabelWithLeftRightImageCellModel(actions: self.cellActions,leftImage:"call-icon", title: "Retrieve by calling Salik (toll free)"))
        self.router?.go(to: .loadBottomSheet(dataSource: dataSource))
        
    }
    
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    func set(accountNumber: String) {
        viewData.inputPhoneNumber = accountNumber
    }
    
    func set(nickname: String) {
        viewData.inputName = nickname
    }
    
    func set(pinNumber: String) {
        viewData.inputPin = pinNumber
        input?.pin = pinNumber
    }
    
    
    func makeDataSource() {
        switch viewData.selectItemType {
        case .mobilEtisalat:
            handleMobileEtisalatView()
        case .homeDu:
            handleHomeDU()
        case .homeEtisalatELife:
            handleHomeEtisalatELife()
        case .homeDEWA:
            handleDEWAView()
        case .homeSEWA,.homeAADC,.homeADDC,.homeEtihadWaterAndElectricity,.homeAjmanSewerage,.homeSERGAS,.govtAjmanPay,.osNationalbonds:
            handleAccountNumberAndNickNameView()
        case .mobileDu:
            handleDuView()
        case .vehicleSalik:
            handleSalikView()
        case .vehicleMawaqif:
            handleMawaqifView(nil)
        case .homeISTA:
            handleISTAView()
        case .osISTARegistration:
            handleISTARegistrationView()
        case .homeLootahGas:
            handleLootahView()
        case .ipMobile:
            handleInternationalMobileView()
        default:
            self.handleAccountNumberAndNickNameView()
        }
        
        view?.provider(image: viewData.selectedItem?.imageUrl ?? "", name: viewData.selectedItem?.title ?? "")
    }
    
    func handleMobileEtisalatView() {
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.mobileNumber, type: .phoneNumber, trailingIcon: "contact-icon",prefix:"+971",limit:9)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.hidePinNumberView()
        view?.hideMawakefView()
//        view?.hideAccountTypeView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    private func handleDEWAView() {
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.enterEeasyPayNumber, type: .numberPad, trailingIcon: "info-circle-bank",prefix:nil,limit:10)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.hidePinNumberView()
        view?.hideMawakefView()
        view?.hideAccountTypeView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    private func handleHomeEtisalatELife(){
        view?.presenter.isPrepaidSelected = false
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.mobileNumber, type: .phoneNumber, trailingIcon: "contact-icon",prefix:"+971",limit:9)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.hidePinNumberView()
        view?.hideMawakefView()
        view?.hideAccountTypeView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    private func handleHomeDU(){
        view?.presenter.isPrepaidSelected = false
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.mobileNumber, type: .phoneNumber, trailingIcon: "contact-icon",prefix:"+971",limit:9)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.hidePinNumberView()
        view?.hideMawakefView()
        view?.hideAccountTypeView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    private func handleDuView() {
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.mobileNumber, type: .phoneNumber, trailingIcon: "contact-icon",prefix:"+971",limit:9)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.hidePinNumberView()
        view?.hideMawakefView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    
    private func handleSalikView() {
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.enterAccountNumber, type: .numberPad, trailingIcon: nil,prefix:nil, limit: 8)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.showPinNumberTextFieldView(placeholder:Strings.BillPayment.enter_salil_pin)
        view?.hideMawakefView()
        view?.hideAccountTypeView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    
    private func  handleMawaqifView(_ prefix:String?) {
        let limit:Int? = prefix != nil ? 9 : 10
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.enterPtvNumber, type: .numberPad, trailingIcon: nil,prefix: prefix,limit:limit)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.hidePinNumberView()
        view?.hideAccountTypeView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    
    private func handleISTAView() {
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.enterBillNumberCustomerId, type: .numberPad, trailingIcon: nil,prefix:nil, limit: nil)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.hidePinNumberView()
        view?.hideMawakefView()
        view?.hideAccountTypeView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    
    private func handleISTARegistrationView() {
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.enterBillNumberCustomerId, type: .numberPad, trailingIcon: nil,prefix:nil, limit: nil)
        view?.hidePinNumberView()
        view?.hideMawakefView()
        view?.hideNicknameView()
        view?.hideAccountTypeView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    
    private func handleLootahView() {
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.enterEbsNumber, type: .text, trailingIcon: nil,prefix:nil,limit:7)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.hidePinNumberView()
        view?.hideMawakefView()
        view?.hideAccountTypeView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    
    private func handleInternationalMobileView() {

        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.mobileNumber, type: .internationalPhoneNumber, trailingIcon: "contact-icon",prefix:"+971",limit:20)
        view?.showFullnameTextFieldView(placeholder:Strings.BillPayment.fullName)
        view?.showAddressTextFieldView(placeholder:Strings.BillPayment.address)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.hidePinNumberView()
        view?.hideMawakefView()
        view?.hideAccountTypeView()
        view?.updateCountryCode(code: viewData.countryCodesList?.first ?? "")
    }
    
    private func handleAccountNumberAndNickNameView(){
        var textLimit:Int = 0
        switch viewData.selectItemType {
        case .homeSEWA:
            textLimit = 11
        case .homeEtihadWaterAndElectricity:
            textLimit = 12
        case .osNationalbonds:
            textLimit = 6
        default:
            textLimit = 10
        }
        view?.showAccountNumberTextFieldView(placeholder:Strings.BillPayment.enterAccountNumber, type: .numberPad, trailingIcon: nil,prefix:nil, limit: textLimit)
        view?.showNicknameTextFieldView(placeholder:Strings.BillPayment.nameNickNameOptional)
        view?.hidePinNumberView()
        view?.hideMawakefView()
        view?.hideAccountTypeView()
        view?.hideFullNameView()
        view?.hideAddressView()
    }
    func updatePhoneNumberTextField(phoneNumber: String) {
        
    }
    
    func loadData() {
        view?.setupUI()
        self.makeDataSource()
    }
    
    func accountNumberTrailingBtnDidTapped() {
        switch viewData.selectItemType {
        case .mobilEtisalat, .mobileDu, .homeEtisalatELife, .homeDu, .ipMobile:
            if let delegate = self.view as? BillAccountDetailsViewController {
                self.router?.go(to: .contacts(delegate: delegate))
            }
        case .homeDEWA:
            var dataSource = [StandardCellModel]()
            dataSource.append(GenericSingleLabelCellModel(content: Strings.BillPayment.easyPayThroughYourDewaBill,font: AppFont.appRegular(size: .body2),color: AppColor.eAnd_Black_80,alignment: .center))
            dataSource.append(GenericSingleLabelCellModel(content: Strings.BillPayment.yourAccountCanBeUsedAsDewa,font: AppFont.appRegular(size: .body3),color: AppColor.eAnd_Grey_100,alignment:.center))
            dataSource.append(SingleImageTableViewCellModel(image: "dewa-info", backgroundImage: ""))
            self.loadBottomDEWAInfoSheet(dataSource: dataSource)
//            Loader.shared.showFullScreenLoaderWithLabel(text: "Redirecting to DEWA website...")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                Loader.shared.hideFullScreenLoaderWithLabel()
//                if let url = URL(string: "https://www.dewa.gov.ae/en/consumer/billing/easypay") {
//                    CommonMethods.openURL(url)
//                }else{
//                    self.loadBottomDEWAInfoSheet(dataSource: dataSource)
//                }
//            }
        default:
            break
        }
    }
    
    func accountNumberLeadingBtnDidTapped() {
        
    }
    
    private func validateAccountNumber(accountNumber: String) -> Bool {
        if accountNumber.isEmpty {
            var errorMessage: String = ""
            switch viewData.selectItemType {
            case .mobilEtisalat, .ipMobile:
                errorMessage = Strings.BillPayment.phoneNumberCannotEmpty
            case .mobileDu:
                errorMessage = Strings.BillPayment.duNumberCannotBeEmpty
            case .homeDEWA:
                errorMessage = Strings.BillPayment.easyPayCannotEmpty
            case .vehicleSalik:
                errorMessage = ""
            case .homeISTA:
                errorMessage = Strings.BillPayment.billNumberCannotEmpty
            case.homeLootahGas:
                errorMessage = Strings.BillPayment.ebsCannotEmpty
            case .osISTARegistration:
                errorMessage = Strings.BillPayment.billNumberCannotEmpty
            case .vehicleMawaqif:
                errorMessage = Strings.BillPayment.billNumberCannotEmpty
            default: return false
            }
            view?.showAccountNumberError(message: errorMessage)
            return false
            
        } else {
            return true
        }
    }
    
    private func validateNickName(nickname: String) -> Bool {
        if nickname.isEmpty && viewData.isSavedForFuture {
            view?.showNicknameError(message:Strings.BillPayment.nicknameRequired)
            return false
        }
        return true
    }
    
    private func validatePinNumber(pin: String) -> Bool {
        if viewData.selectItemType == .vehicleSalik {
            if pin.isEmpty {
                view?.showPinNumberError(message:Strings.BillPayment.pinIsRequired)
                return false
            } else {
                return true
            }
        }
        return true
    }
}

extension BillAccountDetailsPresenter: BillAccountDetailsInteractorOutputProtocol {
    private func showAdditionalInformation (_ data: ValidatePayBillResponse) {
        var dataSource = [StandardCellModel]()
        dataSource.append(SpaceTableViewCellModel(height: 20))
        let cell1 = GenericSingleLabelCellModel(content: Strings.BillPayment.confirmDetails,
                                                font: AppFont.appRegular(size: .body2),
                                                color: AppColor.eAnd_Black_80,
                                                alignment: .center)
        dataSource.append(cell1)
        
        var childData1 = [StandardCellModel]()
        data.data?.additionalInfo?.forEach({
            childData1.append(SpaceTableViewCellModel(height: 12))
            childData1.append(TwoLabelsTableViewCellModel(leadingTitle: /$0.name,
                                                          trailingTitle: /$0.value))
            childData1.append(GenericDividerTableViewCellModel())
        })
        childData1.removeLast()
        let data = TableViewCellModelWithUITableView(dataSource: childData1, borderWidth: 1, borderColor: AppColor.eAnd_Grey_30, cornerRadius: 12, leftSpace: 24, rightSpace: 24, topSpace: 10, bottomSpace: 20)
        dataSource.append(data)
        let confirmButton = BaseButton()
        confirmButton.type = .GradientButton
        confirmButton.setTitle(Strings.BillPayment.confirmBtnText, for: .normal)
        confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        self.router?.go(to: .additionalInfoSheet(dataSource: dataSource, actions: [confirmButton,BaseButton()]))
    }
    @objc private func didTapConfirm() {
        if let input = self.input {
            UIApplication.getTopViewController()?.dismiss(animated: true, completion: {
                self.router?.go(to: .navigateBillEnterAmount(input:input))
            })
        }
        Loader.shared.hideFullScreenLoaderWithLabel()
    }
    func validatePhoneNumberSuccess(data: ValidatePayBillResponse) {
        
        Loader.shared.hideFullScreenLoaderWithLabel()
        var phoneNumber = ""
        if viewData.selectItemType == .mobilEtisalat {
            phoneNumber = "0\(viewData.inputPhoneNumber.replacingOccurrences(of: " ", with: ""))"
        } else {
            phoneNumber = viewData.inputPhoneNumber.replacingOccurrences(of: " ", with: "")
        }
        var input:BillAccountDetailsParameters? =  BillAccountDetailsParameters(billTitle: viewData.inputPhoneNumber,
                                                                                billSubTitle: viewData.inputName,
                                                                                isSavedBill: viewData.isSavedForFuture,
                                                                                billType: viewData.selectItemType,
                                                                                selectedItem: viewData.selectedItem,
                                                                                billDueAmount: data.data?.billedAmount,
                                                                                billMin: data.data?.min ?? "1.00",
                                                                                billMax: data.data?.max ?? "5000",
                                                                                transactionId: data.data?.transactionId,
                                                                                accountNumber: phoneNumber)
        input?.isPrepaid = self.viewData.isprepaidSelected
        self.input = input
        switch(viewData.selectItemType){
        case .mobilEtisalat,.mobileDu:
            input?.subTitle = "+971 " + viewData.inputPhoneNumber
            input?.denominations = data.data?.denominationResponse?.denominations
            if isPrepaidSelected {
                guard let input = input else { return }
                self.router?.go(to: .navigateToSelectPlan(input: input))
                return
            }
        case .ipMobile:
            guard let input = input else { return }
            self.router?.go(to: .mobileInternationalSelectPlan(input: input) )
            return
        case .homeDEWA,.homeISTA, .osISTARegistration:
            break
        case .homeLootahGas:
            self.input?.title = data.data?.additionalInfo?.first(where: { $0.name?.lowercased() == "Customer name".lowercased()})?.value
            self.input?.subTitle = data.data?.additionalInfo?.first(where: { $0.name?.lowercased() == "EBS".lowercased()})?.value
            self.showAdditionalInformation(data)
            return
        case .vehicleMawaqif:
            self.showAdditionalInformation(data)
            return
        case .vehicleSalik:
            input?.denominations = data.data?.denominationResponse?.denominations
            guard let input = input else { return }
            self.router?.go(to: .navigateToSelectPlan(input: input))
            return

        default:
            break
        }
        if let input = input {
            self.router?.go(to: .navigateBillEnterAmount(input:input))
        }
        Loader.shared.hideFullScreenLoaderWithLabel()
    }
    
    func validatePhoneNumberFail(error: AppError) {
        Loader.shared.hideFullScreenLoaderWithLabel()
        Alert.showBottomSheetError(title: Strings.BillPayment.error, message: error.title)
//        view?.showAccountNumberError(message: error.errorDescription)
    }
}

extension BillAccountDetailsPresenter{
    func navigateToEnterAmountScreen() {
        let validAccountNumber = validateAccountNumber(accountNumber: viewData.inputPhoneNumber)
        let validNickName = validateNickName(nickname: viewData.inputName)
        let validPinNumber = validatePinNumber(pin: viewData.inputPin)
        if !validAccountNumber || !validNickName || !validPinNumber {
            return
        }
        Loader.shared.showFullScreenLoaderWithLabel(text: "\(Strings.BillPayment.fetching) \(self.viewData.selectedItem?.title ?? "") \(Strings.BillPayment.account)")
        
        switch viewData.selectItemType {
        case .mobilEtisalat:
            viewData.inputPhoneNumber = viewData.inputPhoneNumber.filter("0123456789.".contains)
            interactor?.validate(msisdn: /GlobalData.shared.msisdn,
                                 accountNumber: "0\(viewData.inputPhoneNumber.replacingOccurrences(of: " ", with: ""))",
                                 serviceId: self.isPrepaidSelected ? "13" : "17",// /self.viewData.selectedItem?.serviceId,
                                 pinNumber: nil)
        case .mobileDu:
            viewData.inputPhoneNumber = viewData.inputPhoneNumber.filter("0123456789.".contains)
            interactor?.validate(msisdn: /GlobalData.shared.msisdn,
                                 accountNumber: "0\(viewData.inputPhoneNumber.replacingOccurrences(of: " ", with: ""))",
                                 serviceId: self.isPrepaidSelected ? "45" : "43",///self.viewData.selectedItem?.serviceId,
                                 pinNumber: nil)
        case .vehicleMawaqif:
            viewData.inputPhoneNumber = viewData.inputPhoneNumber.filter("0123456789.".contains)
            interactor?.validate(msisdn: /GlobalData.shared.msisdn,
                                 accountNumber: "0\(viewData.inputPhoneNumber.replacingOccurrences(of: " ", with: ""))",
                                 serviceId: /self.viewData.selectedItem?.serviceId,
                                 pinNumber: nil)
        case .vehicleSalik:
            interactor?.validate(msisdn: /GlobalData.shared.msisdn,
                                 accountNumber: "\(viewData.inputPhoneNumber.replacingOccurrences(of: " ", with: ""))",
                                 serviceId: /self.viewData.selectedItem?.serviceId,
                                 pinNumber: viewData.inputPin)
        case .homeLootahGas:
            interactor?.validate(msisdn: /GlobalData.shared.msisdn,
                                 accountNumber: viewData.inputPhoneNumber,
                                 serviceId: /self.viewData.selectedItem?.serviceId,
                                 pinNumber: nil)
        default:
            interactor?.validate(msisdn: /GlobalData.shared.msisdn,
                                 accountNumber: "\(viewData.inputPhoneNumber.replacingOccurrences(of: " ", with: ""))",
                                 serviceId: /self.viewData.selectedItem?.serviceId,
                                 pinNumber: nil)
        }
        
    }
    
    private func loadBottomDEWAInfoSheet(dataSource:[StandardCellModel]) {
        self.router?.go(to:.loadBottomSheet(dataSource: dataSource))
    }
    func addNewAccount() {
        self.router?.go(to: .addNewAccount)
    }
    
}
