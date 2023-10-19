//
//  BillAccountDetailsViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//  
//

import UIKit
import ContactsUI
//import DropDown

class BillAccountDetailsViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nextButtonBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var selectServiceLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet private weak var providerImageView: UIImageView!
    @IBOutlet private weak var providerNameLabel: UILabel!
    @IBOutlet private weak var accountType: UIStackView!
    @IBOutlet private weak var selectService: UIStackView!
    @IBOutlet private weak var accountNumberTextFeild: StandardTextField!
    @IBOutlet private weak var fullNameTextFeild: StandardTextField!
    @IBOutlet private weak var addressTextFeild: StandardTextField!
    @IBOutlet private weak var accountNicknameTextField: StandardTextField!
    @IBOutlet private weak var pinNumberTextFeid: StandardTextField!
    @IBOutlet weak var btnContinue: BaseButton!
    @IBOutlet weak var btnCheck: UIButton!
    // MARK: Properties
    @IBOutlet weak var btnPostpaid: UIButton!
    @IBOutlet weak var btnPrepaid: UIButton!
    @IBOutlet weak var btnViolationPayment: UIButton!
    @IBOutlet weak var btnMawaqifTopup: UIButton!
    @IBOutlet weak var btnForgetPassword: BaseButton!
    let dropDown = DropDown()
    var presenter: BillAccountDetailsPresenterProtocol!
    var isCheckBoxHidden:Bool = false
    private var keyboardHelper: KeyboardHelper?
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setAccountNumberView()
        setPinNumberView()
        setNicknameView()
        setContinueButton()
        self.btnForgetPassword.isHidden = self.presenter.viewData.selectItemType != .vehicleSalik
        self.presenter.isMawaqifTopupSelected = false
        self.btnPrepaid.setImage(UIImage(named: "radio_selected"), for: .normal)
        self.btnViolationPayment.setImage(UIImage(named: "radio_selected"), for: .normal)
    }
    
    @IBAction func btnContinuePressed(_ sender: Any) {
        if self.presenter.viewData.isSavedForFuture == true,
                 self.accountNicknameTextField.text.removeWhitespace().isEmpty {
            self.accountNicknameTextField.showError(with: "Nickname is required")
            self.btnContinue.disable()
            return
        }
        self.accountNicknameTextField.hideError()
        accountNumberTextFeild.hideError()
        accountNicknameTextField.hideError()
        fullNameTextFeild.hideError()
        pinNumberTextFeid.hideError()
        addressTextFeild.hideError()
        presenter.set(accountNumber: accountNumberTextFeild.text)
        presenter.set(nickname: accountNicknameTextField.text)
        presenter.set(pinNumber: pinNumberTextFeid.text)
        presenter.navigateToEnterAmountScreen()
    }
    private func validateContinueButton() {
        if self.accountNumberTextFeild.text.removeWhitespace().count > self.accountNumberTextFeild.textLimit {
            self.btnContinue.disable()
            if accountNumberTextFeild.prefix?.hasPrefix("+") == true {
                self.accountNumberTextFeild.showError(with: Strings.BillPayment.error_add_phone)
            }else{
                self.accountNumberTextFeild.showError(with: Strings.BillPayment.error_add_account)
            }
            return
        }
        switch self.presenter.viewData.selectItemType {
        case .vehicleSalik:
            if self.accountNumberTextFeild.text.removeWhitespace().isEmpty || self.pinNumberTextFeid.text.removeWhitespace().isEmpty {
                self.btnContinue.disable()
                return
            }
//            else if self.presenter.viewData.isSavedForFuture == true,
//                     self.accountNicknameTextField.text.removeWhitespace().isEmpty {
//                self.accountNicknameTextField.showError(with: "Nickname is required")
//                self.btnContinue.disable()
//                return
//            }
            else{
                self.btnContinue.enable()
            }
        default:
            if self.accountNumberTextFeild.text.removeWhitespace().isEmpty {
                self.btnContinue.disable()
                if accountNumberTextFeild.prefix?.hasPrefix("+") == true{
                    self.accountNumberTextFeild.showError(with: Strings.BillPayment.error_add_phone)
                }else{
                    self.accountNumberTextFeild.showError(with: Strings.BillPayment.error_add_account)
                }
                return
            }
//            else if self.presenter.viewData.isSavedForFuture == true,
//                     self.accountNicknameTextField.text.removeWhitespace().isEmpty {
//                self.btnContinue.disable()
//                self.accountNicknameTextField.showError(with: "Nickname is required")
//                return
//            }
            else{
                self.btnContinue.enable()
            }
        }
        self.accountNicknameTextField.hideError()
        self.accountNumberTextFeild.hideError()
    }
    private func setContinueButton() {
        switch self.presenter.viewData.selectItemType {
        case .mobilEtisalat,.mobileDu,.vehicleMawaqif:
            self.btnContinue.setTitle(Strings.BillPayment.continueBtnText, for: .normal)
        case .homeDEWA,.homeISTA,.homeLootahGas:
            self.btnContinue.setTitle(Strings.BillPayment.continueToPayBill, for: .normal)
        case .vehicleSalik:
            self.btnContinue.setTitle(Strings.BillPayment.continue_to_topup, for: .normal)
        default:
            self.btnContinue.setTitle(Strings.BillPayment.continueBtnText, for: .normal)
        }
    }
    private func setAccountNumberView() {
        
        accountNumberTextFeild.textChangedCallback = { [weak self] in
            guard let self = self else { return }
            if self.presenter.viewData.selectItemType == .homeLootahGas {
                self.accountNumberTextFeild.text = self.accountNumberTextFeild.text.uppercased()
            }
            self.validateContinueButton()
        }
        accountNumberTextFeild.prefixColor = AppColor.eAnd_Black_80
    }
    
    private func setNicknameView() {
        accountNicknameTextField.showCharactersCount = false
        accountNicknameTextField.textLimit = 50
        accountNicknameTextField.textChangedCallback = { [weak self] in
            guard let self = self else { return }
            self.accountNicknameTextField.setupConfigurations()
            self.validateContinueButton()
            self.accountNicknameTextField.hideError()
        }
    }
    
    private func setPinNumberView() {
        pinNumberTextFeid.isSecureTextEntry = true
        pinNumberTextFeid.trailingButtonImage = "eye-slash"
        pinNumberTextFeid.trailingButtonTappedCallback = {
            self.pinNumberTextFeid.isSecureTextEntry.toggle()
            self.pinNumberTextFeid.trailingButtonImage = self.pinNumberTextFeid.isSecureTextEntry ? "eye-slash": "eye"
        }
        pinNumberTextFeid.textChangedCallback = { [weak self] in
            guard let self = self else { return }
            self.validateContinueButton()
            self.pinNumberTextFeid.hideError()
        }
    }

    func showErrorAlert(title:String,message:String){
        Alert.showBottomSheetError(title: title, message: message)
        return
    }
    
    @IBAction func btnCheckBoxPressed(_ sender: Any) {
        self.presenter.viewData.isSavedForFuture.toggle()
        self.validateContinueButton()
        if self.presenter.viewData.isSavedForFuture {
            self.btnCheck.setImage(UIImage(named:"redCheckbox"), for: .normal)
        }else{
            self.btnCheck.setImage(UIImage(named:"defaultCheckbox"), for: .normal)
        }
    }
    
    @IBAction func accountTypeFirstOption(_ sender: UIButton) {
        self.presenter.viewData.isprepaidSelected = true
        self.presenter.isPrepaidSelected = true
        btnPrepaid.setImage(UIImage(named: "radio_selected"), for: .normal)
        btnPostpaid.setImage(UIImage(named: "radio_unselected"), for: .normal)
    }
    
    @IBAction func accountTypeSecondOption(_ sender: UIButton) {
        self.presenter.viewData.isprepaidSelected = false
        self.presenter.isPrepaidSelected = false
        btnPrepaid.setImage(UIImage(named: "radio_unselected"), for: .normal)
        btnPostpaid.setImage(UIImage(named: "radio_selected"), for: .normal)
    }
    
    @IBAction func serviceTypeFirstOptionPressed(_ sender: Any) {
        self.accountNumberTextFeild.text = ""
        self.presenter.isMawaqifTopupSelected = false
        showAccountNumberTextFieldView(placeholder:Strings.BillPayment.enterPtvNumber, type: .numberPad, trailingIcon: nil, prefix: nil)
        btnViolationPayment.setImage(UIImage(named: "radio_selected"), for: .normal)
        btnMawaqifTopup.setImage(UIImage(named: "radio_unselected"), for: .normal)
        
    }
    @IBAction func serviceTypeSecondOptionPressed(_ sender: Any) {
        self.accountNumberTextFeild.text = ""
        self.presenter.isMawaqifTopupSelected = true
        showAccountNumberTextFieldView(placeholder:Strings.BillPayment.mobileNumber, type: .phoneNumber, trailingIcon: "contact-icon", prefix: "+971")
        btnViolationPayment.setImage(UIImage(named: "radio_unselected"), for: .normal)
        btnMawaqifTopup.setImage(UIImage(named: "radio_selected"), for: .normal)
    }
    
    @IBAction func didPressForgetAccountPin(_ sender:BaseButton) {
        self.presenter.loadForgotPINBottomSheet()
    }
    
}

extension BillAccountDetailsViewController: BillAccountDetailsViewProtocol {
    func showFullnameTextFieldView(placeholder: String) {
        fullNameTextFeild.title = placeholder
    }
    
    func showAddressTextFieldView(placeholder: String) {
        addressTextFeild.title = placeholder
    }
    
    func hideFullNameView() {
        fullNameTextFeild.isHidden = true
    }
    
    func hideAddressView() {
        addressTextFeild.isHidden = true
    }
    
    func showAccountNumberError(message: String) {
        accountNumberTextFeild.showError(with: message)
    }
    func showPinNumberError(message: String) {
        pinNumberTextFeid.showError(with: message)
    }
    func showNicknameError(message: String) {
        accountNicknameTextField.showError(with: message)
    }
    func provider(image: String, name: String) {
        providerImageView.kf.setImage(with: URL(string: image))
        providerNameLabel.text = name
    }
    
    func showAccountNumberTextFieldView(placeholder: String,
                                        type: StandardTextField.EntryType,
                                        trailingIcon: String?,prefix:String?
                                        ,limit:Int? = nil) {
        accountNicknameTextField.textLimit = Int(self.presenter.viewData.selectedItem?.resourceConfig?.maximumDigitLimit ?? "20") ?? 20
        accountNumberTextFeild.entryType = type
        accountNumberTextFeild.prefix = prefix
        if type == .phoneNumber {
            accountNumberTextFeild.placeholder = placeholder
        }else{
            accountNumberTextFeild.title = placeholder
            accountNumberTextFeild.placeholder = ""
        }
        accountNumberTextFeild.prefixColor = AppColor.eAnd_Black_80
        accountNumberTextFeild.trailingButtonImage = trailingIcon
        
        accountNumberTextFeild.trailingButtonTappedCallback = { [weak self] in
            guard let self = self else { return }
            self.presenter.accountNumberTrailingBtnDidTapped()
        }
        
        accountNumberTextFeild.leadingButtonTappedCallback  = { [weak self] in
            guard let self = self else { return }
            if self.presenter.viewData.selectItemType == .ipMobile && self.presenter.viewData.countryCodesList?.count  ?? 0 > 1 {
                self.presenter.accountNumberLeadingBtnDidTapped()
                self.customizeDropDown(dataSource: self.presenter.viewData.countryCodesList ?? [])
            }
        }
        accountNumberTextFeild.setupConfigurations()
    }
    
    func showNicknameTextFieldView(placeholder: String) {
        accountNicknameTextField.title = placeholder
    }
    
    func showPinNumberTextFieldView(placeholder: String) {
        pinNumberTextFeid.textLimit = 4
        pinNumberTextFeid.entryType = .numberPad
        pinNumberTextFeid.title = placeholder
    }
    
    func showMawakefSelectServiceView() {
        
    }
    
    func showAccountTypeView() {
        
    }
    
    func hideAccountNumberView() {
        accountNumberTextFeild.isHidden = true
    }
    
    func hideNicknameView() {
        accountNicknameTextField.isHidden = true
    }
    
    func hidePinNumberView() {
        pinNumberTextFeid.isHidden = true
    }
    
    func hideMawakefView() {
        selectService.isHidden = true
    }
    
    func hideAccountTypeView() {
        accountType.isHidden = true
    }
    
    func updateCountryCode(code: String) {
        accountNumberTextFeild.prefix = code
    }
    
    func reloadData() {
        
    }

    func setupUI() {
        keyboardHelper = KeyboardHelper { [unowned self] animation, keyboardFrame, duration in
            switch animation {
            case .keyboardWillShow:
                nextButtonBottomContraint.constant = keyboardFrame.height
            case .keyboardWillHide:
                nextButtonBottomContraint.constant = 32
            }
        }
        self.btnCheck.setImage(UIImage(named:"redCheckbox"), for: .normal)
        setUpNavbar()
        btnContinue.disable()
        btnContinue.setTitle(Strings.BillPayment.continueBtnText, for: .normal)
        btnContinue.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        btnContinue.type = .GradientButton
        btnCheck.setTitle(Strings.BillPayment.saveThisFutureBill, for: .normal)
        btnCheck.titleLabel?.font = AppFont.appRegular(size: .body4)
        if #available(iOS 15.0, *) {
            btnCheck.configuration?.imagePadding = 8
            btnPrepaid.configuration?.imagePadding = 8
            btnPostpaid.configuration?.imagePadding = 8
            btnViolationPayment.configuration?.imagePadding = 8
            btnMawaqifTopup.configuration?.imagePadding = 8
        } else {
            // Fallback on earlier versions
            btnCheck.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            btnPrepaid.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            btnPostpaid.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            btnViolationPayment.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            btnMawaqifTopup.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        }
        
        switch(self.presenter.viewData.selectItemType) {
        case .osISTARegistration:
            btnCheck.isHidden = true
            isCheckBoxHidden = true
        default:
            btnCheck.isHidden = false
            isCheckBoxHidden = false
        }
        self.btnForgetPassword.type = .PlainButton
        self.btnForgetPassword.setTitle(Strings.BillPayment.forgotAccountOrPIN, for: .normal)
        self.btnForgetPassword.titleLabel?.font = AppFont.appMedium(size: .body4)
        self.btnForgetPassword.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        self.selectServiceLabel.font = AppFont.appSemiBold(size: .body2)
        self.selectServiceLabel.text = Strings.BillPayment.selectTheService
        self.accountTypeLabel.text = Strings.BillPayment.accountType
        self.accountTypeLabel.font = AppFont.appSemiBold(size: .body2)
        self.providerNameLabel.font = AppFont.appSemiBold(size: .body2)
        
        self.btnViolationPayment.setTitle(Strings.BillPayment.violationPayment, for: .normal)
        self.btnViolationPayment.titleLabel?.font = AppFont.appRegular(size: .body4)
        
        self.btnMawaqifTopup.setTitle(Strings.BillPayment.mMawaqifAccountTopUp, for: .normal)
        self.btnMawaqifTopup.titleLabel?.font = AppFont.appRegular(size: .body4)
        
        self.btnPrepaid.setTitle(Strings.BillPayment.prepaid, for: .normal)
        self.btnPostpaid.setTitle(Strings.BillPayment.postpaid, for: .normal)
        
        self.btnPrepaid.titleLabel?.font = AppFont.appRegular(size: .body4)
        self.btnPostpaid.titleLabel?.font = AppFont.appRegular(size: .body4)
    }
    
    private func setUpNavbar(){
        self.navigationItem.setTitle(title:self.presenter.viewData.navTitle, subtitle:Strings.BillPayment.accountDetails)
        self.createNavBackBtn()
    }
}
extension BillAccountDetailsViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.accountNumberTextFeild.hideError()
        self.accountNicknameTextField.hideError()
        self.accountNumberTextFeild.text = /contact.phoneNumbers.first?.value.stringValue
        self.accountNumberTextFeild.setupConfigurations()
        self.accountNicknameTextField.text = /CNContactFormatter.string(from: contact, style: .fullName)
        self.accountNicknameTextField.setupConfigurations()
    }
}

extension BillAccountDetailsViewController {
    func customizeDropDown(dataSource:[String]) {
        
        dropDown.anchorView = self.accountNumberTextFeild
        dropDown.width = 52
        dropDown.bottomOffset = CGPoint(x:0, y: self.accountNumberTextFeild.frame.height + 8)
        dropDown.cellHeight = 70
        dropDown.direction = .bottom
        dropDown.textFont = AppFont.appMedium(size: .body4)
        dropDown.textColor = AppColor.eAnd_Black_80
        dropDown.cancelAction = { [weak self] in
            self?.accountNumberTextFeild.resignFirstResponder()
        }
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = dataSource
        
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.cellNib = UINib(nibName: "CustomDropDownCell", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK"))
        dropDown.backgroundColor = .white
        dropDown.setupCornerRadius(16)
        dropDown.customCellConfiguration = { index, item, cell in
            guard let customCell = cell as? CustomDropDownCell else { return }
            customCell.setLabelTralinlingConstraints(value: 2)
            customCell.setLabelLeadingConstraints(value: 2)
            customCell.setSeparatorTralinlingConstraints(value: 1)
            customCell.setSeparatorLeadingConstraints(value: 1)
            customCell.setLabelTextAlignment(alignment: .center)
            if index == self.dropDown.dataSource.count - 1 {
                customCell.separatorView.isHidden = true
            }else{
                customCell.separatorView.isHidden = false
            }
        }
        dropDown.selectionAction = { (index,item) in
            self.accountNumberTextFeild.prefix = item
            self.accountNumberTextFeild.resignFirstResponder()
            self.accountNumberTextFeild.hideError()
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        dropDown.show()
    }
}


