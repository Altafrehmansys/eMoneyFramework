//
//  SendMoneyToBankAccountViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation
import UIKit

class SendMoneyToBankAccountViewController: BaseViewController {
    
    @IBOutlet weak var iBANNumberTextField: StandardTextField!
    @IBOutlet weak var btnSendMoney: BaseButton!
    @IBOutlet weak var accountHoldeNameTextField: StandardTextField!
    @IBOutlet weak var nickNameTextField: StandardTextField!
    @IBOutlet weak var lblSaveBeneficiary: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    
    // MARK: Properties
    
    var presenter: SendMoneyToBankAccountPresenterProtocol?
    var isSaveBeneficary = true
    let prefix = "AE "
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpUI()
        setUpNavbar()
    }
    private func setUpNavbar(){
        self.navigationItem.setTitle(title: "Send money",subtitle: "Add beneficiary")
        self.createNavBackBtn()
    }
    private func setUpUI(){
       
        iBANNumberTextField.title = "Enter beneficiary IBAN"
        accountHoldeNameTextField.title = "Account holder full name"
        nickNameTextField.title = "Nickname"
        
        iBANNumberTextField.textFieldTextColor = AppColor.eAnd_Black_80
        accountHoldeNameTextField.textFieldTextColor = AppColor.eAnd_Black_80
        nickNameTextField.textFieldTextColor = AppColor.eAnd_Black_80
        
        iBANNumberTextField.prefix = "AE"
        
        iBANNumberTextField.textFieldFont = AppFont.appRegular(size: .body2)
        accountHoldeNameTextField.textFieldFont = AppFont.appRegular(size: .body2)
        accountHoldeNameTextField.textFieldFont = AppFont.appRegular(size: .body2)
        
        iBANNumberTextField.state = .normal
        accountHoldeNameTextField.state = .normal
        nickNameTextField.state = .normal
        iBANNumberTextField.trailingButtonImage = "info-circle-bank"
        iBANNumberTextField.trailingButtonTappedCallback = {
            print("clicked")
            self.loadIBANNumberInfo()
        }
        
        lblSaveBeneficiary.text = "Save beneficiary for upcoming transfers"
        lblSaveBeneficiary.font = AppFont.appRegular(size: .body4)
        self.setupDelegateForTextField()
    }
    
     func loadIBANNumberInfo(){
         presenter?.showIbanInfoView()
    }
    
    private func getAtrributed() -> NSAttributedString {
        return iBANNumberTextField.text.withBoldText(boldPartsOfString: [self.prefix], font: AppFont.appRegular(size: .body3), boldFont: AppFont.appSemiBold(size: .body2))
    }
    
    func setupDelegateForTextField() {
        iBANNumberTextField.textChangedCallback = { [weak self] in
            guard let self = self else { return }
            self.iBANNumberTextField.attributedText = self.getAtrributed()
            
        }
        iBANNumberTextField.textFieldDidBeginEditingCallback = { [unowned self] in
            if !iBANNumberTextField.text.contains(self.prefix) {
                self.addPrefix()
            }
        }
        iBANNumberTextField.textFieldDidEndEditingCallback = { [weak self] in
            guard let self = self else { return }
            let str = self.iBANNumberTextField.text.replacingOccurrences(of: self.prefix, with: "")
            // If user not added price the removing the prefix
            if str.isEmpty {
                self.removePrefix()
            }
        }

        iBANNumberTextField.textFieldShouldChangeCharsInRnage = { range, replacement -> Bool in
            if !replacement.isDecimal && replacement.count > 0 {
                return false
            }
            let protectedRange = NSMakeRange(2, 1)
            let intersection = NSIntersectionRange(protectedRange, range)
            if intersection.length > 0 {
                return false
            }
            return true
        }
    }

    func addPrefix() {
        let attributedString = NSMutableAttributedString(string: self.prefix)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColor.eAnd_Black_80, range: NSMakeRange(0, 2))
        attributedString.addAttribute(NSAttributedString.Key.font, value: AppFont.appSemiBold(size: .body2), range: NSMakeRange(0, 2))
        iBANNumberTextField.attributedText = attributedString
    }

    func removePrefix() {
        iBANNumberTextField.text = ""
    }
    
    @IBAction func sendMoneyButtonPressed(_ sender: Any) {
        self.presenter?.navigateToSendMoneyEnterAmount()
    }
    
    @IBAction func btnCheckBoxPressed(_ sender: Any) {
        
        self.btnCheckBox.setImage(UIImage(named:"defaultCheckbox"), for: .normal)
        isSaveBeneficary = !isSaveBeneficary
        if isSaveBeneficary {
            self.btnCheckBox.setImage(UIImage(named:"redCheckbox"), for: .normal)
        }
    }
}

extension SendMoneyToBankAccountViewController: SendMoneyToBankAccountViewProtocol {
    
}
