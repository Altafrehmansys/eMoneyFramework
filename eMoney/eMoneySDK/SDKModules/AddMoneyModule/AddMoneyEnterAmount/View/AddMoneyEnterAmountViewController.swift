//
//  AddMoneyEnterAmountViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 28/04/2023.
//  
//

import Foundation
import UIKit
import PassKit

class AddMoneyEnterAmountViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var selectedBankLogoImageView: UIImageView!
    @IBOutlet weak var selectedBankNameLabel: UILabel!
    @IBOutlet weak var selectedBankAccountNumberLabel: UILabel!
    @IBOutlet weak var amountTagListView: TagListView!
    @IBOutlet weak var amountField: BaseAmountField!
    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var orSelectAnAmountLabel: UILabel!
    @IBOutlet weak var applePayBtn: UIButton!
    @IBOutlet weak var nextBtn: BaseButton! {
        didSet {
            nextBtn.isEnabled = false
        }
    }
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: Apple pay Parameters
    private var paymentRequest : PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.ae.comtrust.ipg"
        request.supportedNetworks = [.masterCard,.visa,.amex]
        request.supportedCountries = ["US"]
        request.merchantCapabilities = .capability3DS
        if #available(iOS 15.0, *) {
            request.couponCode = "AED"
        }
        request.currencyCode = "AED"
        request.countryCode = "US"
        return request
    }()
    
    var paymentStatus = PKPaymentAuthorizationStatus.failure

    
    // MARK: Properties
    var presenter: AddMoneyEnterAmountPresenterProtocol!

    // Computed Properties
    var formattedAmountString: String {
        get {
            let amountString = amountField.text?.replace(string: Strings.Generic.currency + " ", replacement: "") ?? ""
            let amount = Double(amountString) ?? 0.0
            return amount.formattedAmountWithComma
        }
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        amountField.becomeFirstResponder = true
    }
}

// MARK: - Class Methods
extension AddMoneyEnterAmountViewController: AddMoneyEnterAmountViewProtocol {
    func setupUI() {
        setupNavigation()
        
        selectedBankNameLabel.text = presenter.title
        selectedBankNameLabel.font = AppFont.appRegular(size: .body3)
        selectedBankNameLabel.textColor = AppColor.eAnd_Black_80
        
        applePayBtn.layer.cornerRadius = 12.0
        applePayBtn.layer.masksToBounds = true
        
        if presenter.logo.contains("http"), let url = URL(string: presenter.logo) {
            selectedBankLogoImageView.load(url: url)
        } else {
            selectedBankLogoImageView.image = UIImage(named: presenter.logo)
        }
        
        selectedBankAccountNumberLabel.isHidden = presenter.subtitle.isEmpty
        selectedBankAccountNumberLabel.text = presenter.subtitle
        selectedBankAccountNumberLabel.font = AppFont.appRegular(size: .body4)
        selectedBankAccountNumberLabel.textColor = AppColor.eAnd_Grey_100
        
        amountField.fieldTypeEnum = .enable
        amountField.currentColor = AppColor.eAnd_Black_80
        amountField.tintColor = AppColor.eAnd_Red_100
        amountField.settingView(desc: "")
        amountField.textChangedCallback = { [unowned self] in
            self.enableDisableContinueButton()
        }
        
        errorLabel.font = AppFont.appRegular(size: .body4)
        errorLabel.textColor = AppColor.eAnd_Red_100
        
        orSelectAnAmountLabel.text = Strings.AddMoney.selectAnAmountAED
        orSelectAnAmountLabel.textColor = AppColor.eAnd_Grey_100
        orSelectAnAmountLabel.font = AppFont.appRegular(size: .body3)
        
        applePayBtn.isHidden = true
        if presenter.currentFlow == .applePay {
            applePayBtn.isHidden = false
            applePayBtn.isEnabled = false
            nextBtn.isHidden = true
            let iconImage = UIImage(systemName: "applelogo")
            applePayBtn.setImage(iconImage, for: .normal)
            applePayBtn.setTitle(" \(Strings.AddMoney.pay)", for: .normal)
            
            UIView.animate(withDuration: 0.3) {
                self.applePayBtn.alpha = 0.5
                self.applePayBtn.setTitleColor(UIColor.lightGray, for: .disabled)
            }
        }
                
        amountTagListView.delegate = self
        amountTagListView.textFont = AppFont.appRegular(size: .body2)
        amountTagListView.textColor = AppColor.eAnd_Black_70
        amountTagListView.borderColor = .clear
        amountTagListView.alignment = .center
        
        self.addAmountTaggs()
        
        self.updateBottomBtnConstraintOnKeyboardAppearing(nextButtonBottomConstraint, bottomPadding: 24)
    }
    
    private func addAmountTaggs() {
        if let denominations = GlobalData.shared.addMoneyMetaDataResponse?.data?.denominations {
            if let list = denominations.denominations {
                list.forEach({self.amountTagListView.addTag("\($0)")})
            }
        }
    }

    private func setupNavigation() {
        let walletBalance = (GlobalData.shared.availableBalance?.balance ?? 0.0).formattedAmountWithComma
        let subtitle = Strings.AddMoney.walletBalance + " " + Strings.Generic.currency + " " + walletBalance
        self.navigationItem.setTitle(title: Strings.AddMoney.addMoneyTitle, subtitle: subtitle, isBoldTitle: true)
        self.createNavBackBtn()
    }
    
    private func enableDisableContinueButton() {
        if let text = amountField.text?.replace(string: Strings.Generic.currency + " ", replacement: "") {
            let enteredAmount = Double(text) ?? 0.0
            self.checkIsEnteredAmountValid(amount: enteredAmount)
        }
    }
    
    private func checkIsEnteredAmountValid(amount: Double) {
        var minLimit: Double = 0.0
        var maxLimit: Double = 0.0
        
        if let selectedBank = presenter.selectedLeanBank {
            minLimit = Double(selectedBank.minLimit ?? 0)
            maxLimit = Double(selectedBank.maxLimit ?? 0)
        } else {
            let denominations = GlobalData.shared.addMoneyMetaDataResponse?.data?.denominations
            minLimit = denominations?.min ?? 0.0
            maxLimit = denominations?.max ?? 0.0
        }
        
        if amount == 0.0 {
            applePayAndNextBtnDisabled()
            errorLabel.isHidden = true
        } else if amount < minLimit {
            errorLabel.text = Strings.AddMoney.minAmountLimitMsg + " " + Strings.Generic.currency + " " + minLimit.formattedAmountWithComma
            errorLabel.isHidden = false
            applePayAndNextBtnDisabled()
        } else if amount > maxLimit {
            errorLabel.text = Strings.AddMoney.maxAmountLimitMsg + " " + Strings.Generic.currency + " " + maxLimit.formattedAmountWithComma
            errorLabel.isHidden = false
            applePayAndNextBtnDisabled()
        } else {
            applePayAndNextBtnEnabled()
            errorLabel.isHidden = true
        }
    }
    
    func applePayAndNextBtnDisabled(){
        nextBtn.isEnabled = false
        applePayBtn.isEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.applePayBtn.alpha = 0.5
            self.applePayBtn.setTitleColor(UIColor.lightGray, for: .disabled)
        }
    }
    
    func applePayAndNextBtnEnabled(){
        nextBtn.isEnabled = true
        applePayBtn.isEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.applePayBtn.alpha = 1
            self.applePayBtn.setTitleColor(AppColor.eAnd_White, for: .normal)
        }
    }
}

// MARK: - Actions
extension AddMoneyEnterAmountViewController {
    @IBAction func edtiButtonTappedAction(_ sender: BaseButton) {
        presenter.goBack()
    }
    
    @IBAction func nextButtonTappedAction(_ sender: BaseButton) {
        if let text = amountField.text, !text.isEmpty {
            presenter.confirmAmount(with: (Strings.Generic.currency + " " + formattedAmountString))
        }
    }
    
    @IBAction func payButtonTappedAction(_ sender: Any) {
        if let text = amountField.text, !text.isEmpty {
            presenter.initiatApplePayFlow(with: formattedAmountString)
        }
    }
}

// MARK: - Apple Pay Flow
extension AddMoneyEnterAmountViewController {
    func tapApplePay() {
        DispatchQueue.main.async {
            let text = self.amountField.text
            let cleanedString = text?.replace(string: Strings.Generic.currency + " ", replacement: "")
            if let amount = Double(cleanedString ?? "") {
                let paymentAmount = NSDecimalNumber(value: amount)
                let paymentSummaryItem = PKPaymentSummaryItem(label: "e&Money", amount: paymentAmount)
                self.paymentRequest.paymentSummaryItems = [paymentSummaryItem]
            }
            
            if let controller = PKPaymentAuthorizationViewController(paymentRequest: self.paymentRequest) {
                controller.delegate = self
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}

extension AddMoneyEnterAmountViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true) {
            if self.paymentStatus == .failure {
                Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong,
                                           message: Strings.AddMoney.applePayErrorMessage,
                                           actionBtnTitle: Strings.Generic.tryAgain,
                                           secondryBtnTitle: Strings.AddMoney.tryUsingAnotherMethod,
                                           delegate: self)
            }
        }
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        if payment.token.paymentMethod.type.rawValue == 1 {
            self.paymentStatus = .failure
            completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
        } else {
            self.paymentStatus = .success
            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
            do {
                if let paymentData = try? JSONSerialization.jsonObject(with: payment.token.paymentData, options: .mutableContainers) as? [AnyHashable: Any] {
                    presenter?.submitPaymentRequest(paymentData: paymentData)
                }
            } catch let error {
                self.paymentStatus = .failure
                completion(PKPaymentAuthorizationResult(status: .failure, errors: [error]))
            }
        }
    }
}

// MARK: TagListViewDelegate
extension AddMoneyEnterAmountViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        amountField.text = Double(title)?.formattedPrice
        self.enableDisableContinueButton()
    }
}
// MARK: - Delegate Methods
extension AddMoneyEnterAmountViewController: GeneralBottomSheetErrorViewDelegate {
    func tryAgainBtnTapped(index: Int) {
        self.tapApplePay()
    }
    
    func secondryBtnTapped() {
        presenter.goBack()
    }
}
