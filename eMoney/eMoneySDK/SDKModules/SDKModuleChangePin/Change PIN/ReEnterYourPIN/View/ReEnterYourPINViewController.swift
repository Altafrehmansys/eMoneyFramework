//
//  ReEnterYourPINViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation
import UIKit

class ReEnterYourPINViewController: BaseViewController {

    @IBOutlet weak var btnNext: BaseButton!
    @IBOutlet weak var btnShowHide: UIButton!
    @IBOutlet weak var newPINTextField: StandardTextField!
    @IBOutlet weak var enterYourNewLabel: UILabel!
    @IBOutlet weak var labelPinMismatch: UILabel!
    // MARK: Properties
    
    var isPasswordHide = true
    var pinPassword = String()
    var otpInputCode = String()
    var presenter: ReEnterYourPINPresenterProtocol?
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpNavBar()
        setViewInterface()
        
        self.keyboardCallBack = { [weak self] (isHidden, frame) in
            if isHidden {
                self?.setScreenSize(size: .halfScreen)
            } else {
                self?.setScreenSize(size: .fullScreen)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setScreenSize(size: .halfScreen)
    }
    
    private func setUpNavBar(){
        self.navigationItem.setTitle(title:"change_pin".localized, subtitle:"re_enter_pin_title".localized)
    }
    
    // MARK: Setting View Interface
    func setViewInterface(){
        self.isHideNavigation(false)
        self.createNavBackBtn()
        
        setFontsAndText()
        configureOtpField()
        setIsPasswordHide(passwordHide: isPasswordHide)
        
//        self.updateBottomBtnConstraintOnKeyboardAppearing(self.constraintButtonBottom, bottomPadding: 32)
    }
    
    func setFontsAndText(){
        
        enterYourNewLabel.textColor = AppColor.eAnd_Black_80
        enterYourNewLabel.font = AppFont.appRegular(size: .body2)
        enterYourNewLabel.text = "use_this_pin".localized
        
        self.newPINTextField.title = "enter_pin".localized
        self.newPINTextField.state = .normal
        self.newPINTextField.textFieldFont = AppFont.appRegular(size: .h7)
        self.newPINTextField.textFieldTextColor = AppColor.eAnd_Black_80
        self.newPINTextField.entryType = .numberPad
                
        labelPinMismatch.text = "pin_mismatch".localized
        labelPinMismatch.textColor = AppColor.eAnd_Error_100
        labelPinMismatch.font = AppFont.appRegular(size: .body4)
        labelPinMismatch.isHidden = true
        
        btnShowHide.setTitle("show".localized, for: .normal)
        btnShowHide.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        btnShowHide.titleLabel?.font = AppFont.appMedium(size: .body4)
        btnShowHide.setImage(UIImage(named:"eye"), for: .normal)
        self.btnNext.disable()
    }
    
    func validateOtpPin(otpCode : String) -> Bool {
        if otpCode == self.pinPassword {
           // self.buttonSetPin.enable()
            
            self.otpInputCode = otpCode
            return true
        }
        else {
            print("Invalid Pin")
            
            self.labelPinMismatch.isHidden = false
           
           // self.buttonSetPin.disable()
            return false
            
            //self.textFieldOtp.setError()
            //let _ = AlertMessages.init(fromError: "Error", message: "Invalid Pin")
        }
    }
    
    func setIsPasswordHide(passwordHide : Bool){
        if passwordHide {
            btnShowHide.setTitle("show".localized, for: .normal)
            btnShowHide.setTitleColor(AppColor.eAnd_Error_100, for: .normal)
            btnShowHide.titleLabel?.font = AppFont.appRegular(size: .body4)
            btnShowHide.setImage(UIImage(named:"eye"), for: .normal)
            self.newPINTextField.isSecureTextEntry = true
        }
        else {
            btnShowHide.setTitle("hide".localized, for: .normal)
            btnShowHide.setTitleColor(AppColor.eAnd_Error_100, for: .normal)
            btnShowHide.titleLabel?.font = AppFont.appRegular(size: .body4)
            btnShowHide.setImage(UIImage(named:"eye-slash"), for: .normal)
            self.newPINTextField.isSecureTextEntry = false
        }
    }
    
    func configureOtpField() {
        self.newPINTextField.entryType = .numberPad
        self.newPINTextField.textFieldFont = AppFont.appRegular(size: .h7)
        self.newPINTextField.textFieldTextColor = AppColor.eAnd_Black_80
        self.newPINTextField.textLimit = 8
        self.newPINTextField.state = .normal
        setupTextFieldDelegates()
    }
    
    private func setupTextFieldDelegates() {
        newPINTextField.textChangedCallback = {
            self.buttonEnableDisable(code: self.newPINTextField.text)
            self.labelPinMismatch.isHidden = true
            //self.validateOtpPin(otpCode: self.textFieldOtp.text)
        }
    }
    
    func buttonEnableDisable(code : String) {
        if code.count > 3 {
            self.btnNext.enable()
        }
        else {
            self.btnNext.disable()
        }
    }
    
    @IBAction func btnShowHidePressed(_ sender: Any) {
        isPasswordHide = !isPasswordHide
        setIsPasswordHide(passwordHide: isPasswordHide)
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        view.endEditing(true)
        let isValid = validateOtpPin(otpCode: self.newPINTextField.text)
        if isValid {
            presenter?.changePinRequest(pin: UserDefaultHelper.userLoginPin ?? "", newPin: self.pinPassword)
        }
        
    }
}

extension ReEnterYourPINViewController: ReEnterYourPINViewProtocol {
    
}
