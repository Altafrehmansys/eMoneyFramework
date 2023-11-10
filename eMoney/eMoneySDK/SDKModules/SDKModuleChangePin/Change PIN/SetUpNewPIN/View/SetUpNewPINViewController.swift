//
//  SetUpNewPINViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation
import UIKit

class SetUpNewPINViewController: BaseViewController {
    @IBOutlet weak var enterYourLabel: UILabel!
    
    @IBOutlet weak var pinTextField: StandardTextField!
    
    @IBOutlet weak var labelWeakPin: UILabel!
    @IBOutlet weak var imageViewRepeatNum: UIImageView!
    @IBOutlet weak var labelConsecutiveNum: UILabel!
    @IBOutlet weak var labelRepeatNum: UILabel!
    @IBOutlet weak var imageViewConsecutiveNum: UIImageView!
    @IBOutlet weak var labelavoidDob: UILabel!
    @IBOutlet weak var imageViewAvoidDob: UIImageView!
    @IBOutlet weak var labelMinMaxLength: UILabel!
    @IBOutlet weak var imageViewMinMaxLengh: UIImageView!

    // MARK: Properties
    @IBOutlet weak var btnShowHide: UIButton!
    var presenter: SetUpNewPINPresenterProtocol?
    
    var otpInputCode = String()
    var pinTypeEnum = PinSecurity.weakPin
    var isPasswordHide = true
    var checkPin = [String:Bool]()

    @IBOutlet weak var btnNext: BaseButton!
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpNavBar()
        setViewInterface()
        
        self.keyboardCallBack = {[weak self] (isHidden, frame) in
            if isHidden {
                self?.setScreenSize(size: .halfScreen)
            } else {
                self?.setScreenSize(size: .fullScreen)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setScreenSize(size: .halfScreen)
    }
    
    private func setUpNavBar(){
        self.navigationItem.setTitle(title:"change_pin".localized, subtitle:"set_new_pin".localized)
    }
    
    // MARK: Setting View Interface
    func setViewInterface(){
        self.isHideNavigation(false)
        self.createNavBackBtn()
        
        setFontsAndText()
        configureOtpField()
        checkPin.updateValue(false, forKey: "repeat")
        checkPin.updateValue(false, forKey: "consecutive")
        checkPin.updateValue(false, forKey: "isBirthYear")
        setIsPasswordHide(passwordHide: isPasswordHide)
        
//        self.updateBottomBtnConstraintOnKeyboardAppearing(self.constraintButtonBottom, bottomPadding: 32)
        
        imageViewMinMaxLengh.image = UIImage(named:"slash-black")
        imageViewConsecutiveNum.image = UIImage(named:"slash-black")
        imageViewRepeatNum.image = UIImage(named:"slash-black")
        imageViewAvoidDob.image = UIImage(named:"slash-black")
    }
    
    func setFontsAndText(){
        
        enterYourLabel.textColor = AppColor.eAnd_Black_80
        enterYourLabel.font = AppFont.appRegular(size: .body2)
        enterYourLabel.text = "enter_new_pin".localized
        
        self.pinTextField.title = "enter_pin".localized
        self.pinTextField.state = .normal
        self.pinTextField.textFieldFont = AppFont.appRegular(size: .h7)
        self.pinTextField.textFieldTextColor = AppColor.eAnd_Black_80
        self.pinTextField.entryType = .numberPad
        
        labelMinMaxLength.text = "pin_instructions_first".localized
        labelMinMaxLength.textColor = AppColor.eAnd_Grey_100
        labelMinMaxLength.font = AppFont.appRegular(size: .body4)
        
        labelRepeatNum.text = "do_not_use_repeating_characters".localized
        labelRepeatNum.textColor = AppColor.eAnd_Grey_100
        labelRepeatNum.font = AppFont.appRegular(size: .body4)
        
        labelConsecutiveNum.text = "do_not_use_consecutive_characters".localized
        labelConsecutiveNum.textColor = AppColor.eAnd_Grey_100
        labelConsecutiveNum.font = AppFont.appRegular(size: .body4)
        
        labelavoidDob.text = "do_not_use_birth_characters".localized
        labelavoidDob.textColor = AppColor.eAnd_Grey_100
        labelavoidDob.font = AppFont.appRegular(size: .body4)
        
        btnShowHide.setTitle("show".localized, for: .normal)
        btnShowHide.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        btnShowHide.titleLabel?.font = AppFont.appMedium(size: .body4)
        btnShowHide.setImage(UIImage(named:"eye"), for: .normal)
        
        labelWeakPin.text = "weak_pin".localized
        labelWeakPin.textColor = AppColor.eAnd_Red_100
        labelWeakPin.font = AppFont.appMedium(size: .body4)
        setStateOnNoInput()
        self.btnNext.disable()
    }
    
    func setIsPasswordHide(passwordHide : Bool){
        if passwordHide {
            btnShowHide.setTitle("show".localized, for: .normal)
            btnShowHide.setTitleColor(AppColor.eAnd_Error_100, for: .normal)
            btnShowHide.titleLabel?.font = AppFont.appRegular(size: .body4)
            btnShowHide.setImage(UIImage(named:"eye"), for: .normal)
            self.pinTextField.isSecureTextEntry = true
        }
        else {
            btnShowHide.setTitle("hide".localized, for: .normal)
            btnShowHide.setTitleColor(AppColor.eAnd_Error_100, for: .normal)
            btnShowHide.titleLabel?.font = AppFont.appRegular(size: .body4)
            btnShowHide.setImage(UIImage(named:"eye-slash"), for: .normal)
            self.pinTextField.isSecureTextEntry = false
        }
    }
    
    func setStateOnNoInput(){
        labelWeakPin.isHidden = true
    }
    
    func configureOtpField() {
        self.pinTextField.entryType = .numberPad
        self.pinTextField.textLimit = 8
        setupTextFieldDelegates()
    }
    
    private func setupTextFieldDelegates() {
        pinTextField.textChangedCallback = {
            //self.validateOtpText(code:self.textFieldOtp.text)
            self.validatePin(self.pinTextField.text)
        }
    }
    
    func validatePin(_ inputStr: String){
        // Rule 1: Check if the string length is between 4 and 8 characters.
        if inputStr.count < 4 {
            imageViewMinMaxLengh.image = UIImage(named:"slash")
            imageViewConsecutiveNum.image = UIImage(named:"slash-black")
            imageViewRepeatNum.image = UIImage(named:"slash-black")
            imageViewAvoidDob.image = UIImage(named:"slash-black")
            self.btnNext.disable()
            
            if inputStr.isEmpty {
                imageViewMinMaxLengh.image = UIImage(named:"slash-black")
                setStateOnNoInput()
            }
            return
        }else{
            self.btnNext.enable()
            imageViewMinMaxLengh.image = UIImage(named:"tick-circle")
        }
        
        // Rule 2: Check if the string contains consecutive numbers.
        var list = [Int]()
        let digits = inputStr.compactMap(\.wholeNumberValue)
        for digit in digits {
            list.append(digit)
        }
        if list.numbersAreConsecutive() {
            imageViewConsecutiveNum.image = UIImage(named:"slash")
            checkPin.updateValue(true, forKey: "consecutive")
        }else{
            imageViewConsecutiveNum.image = UIImage(named:"tick-circle")
            checkPin.updateValue(false, forKey: "consecutive")
        }

        
        // Rule 3: Check if the string contains repetitive numbers like "1111".
        if inputStr.isMonotonous {
            print("repetitive")
            imageViewRepeatNum.image = UIImage(named:"slash")
            checkPin.updateValue(true, forKey: "repeat")
        }else{
            imageViewRepeatNum.image = UIImage(named:"tick-circle")
            checkPin.updateValue(false, forKey: "repeat")
        }
        
        // Rule 4: Check date of birth.
        if inputStr.count == 4 && (inputStr.hasPrefix("19") || inputStr.hasPrefix("20")) {
            imageViewAvoidDob.image = UIImage(named:"slash")
            checkPin.updateValue(true, forKey: "isBirthYear")
            self.btnNext.disable()
        }else{
            imageViewAvoidDob.image = UIImage(named:"tick-circle")
            checkPin.updateValue(false, forKey: "isBirthYear")
            self.btnNext.enable()
        }
        setPinStrength(dictionary: checkPin)
        
        self.otpInputCode = inputStr
    }
    
    func setPinStrength(dictionary : [String:Bool]){
        
        let consecutive = dictionary["consecutive"]
        let repetitive = dictionary["repeat"]
        let birthYear = dictionary["isBirthYear"]
        
        if !(consecutive ?? false) && !(repetitive ?? false) && !(birthYear ?? false) {
            pinTypeEnum = .strongPin
        }
        else if (consecutive ?? false) || (repetitive ?? false) {
            pinTypeEnum = .weakPin
        }
        else if (birthYear ?? false) {
            pinTypeEnum = .weakPin
        }
        
        setPinStrengthView()
    }
    
    func setPinStrengthView(){
        switch pinTypeEnum {
        case .weakPin:
            self.labelWeakPin.text = "weak_pin".localized
            labelWeakPin.textColor = AppColor.eAnd_Red_100
        case .strongPin:
            labelWeakPin.textColor = AppColor.greenSuccessHex
            self.labelWeakPin.text = "strong_pin".localized
        case .average:
            self.labelWeakPin.text = "average_pin".localized
            labelWeakPin.textColor = AppColor.eAnd_Warning_100
        }
        labelWeakPin.isHidden = false
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        view.endEditing(true)
        self.presenter?.navigateToReEnterPin(pin: self.otpInputCode)
    }
    
    @IBAction func buttonShowHideTapped(_ sender: Any) {
        isPasswordHide = !isPasswordHide
        setIsPasswordHide(passwordHide: isPasswordHide)
    }
}

extension SetUpNewPINViewController: SetUpNewPINViewProtocol {
    
}
