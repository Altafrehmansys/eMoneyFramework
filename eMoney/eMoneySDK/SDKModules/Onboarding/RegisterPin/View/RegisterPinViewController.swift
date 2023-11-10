//
//  RegisterPinViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 19/04/2023.
//  
//

import Foundation
import UIKit
//import IQKeyboardManagerSwift

class RegisterPinViewController: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var constraintButtonBottom: NSLayoutConstraint!
    @IBOutlet weak var viewStepperTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var labelSecureAccount: UILabel!
    @IBOutlet weak var textFieldOtp: StandardTextField!
    @IBOutlet weak var viewStepper: BaseStepper!
    @IBOutlet var labelWeakPin: UILabel!
    @IBOutlet weak var imageViewWeak: UIImageView!
    @IBOutlet weak var labelHide: UILabel!
    @IBOutlet weak var imageViewHide: UIImageView!
    @IBOutlet weak var imageViewRepeatNum: UIImageView!
    @IBOutlet weak var labelConsecutiveNum: UILabel!
    @IBOutlet weak var labelRepeatNum: UILabel!
    @IBOutlet weak var imageViewConsecutiveNum: UIImageView!
    @IBOutlet weak var labelavoidDob: UILabel!
    @IBOutlet weak var imageViewAvoidDob: UIImageView!
    @IBOutlet weak var labelMinMaxLength: UILabel!
    @IBOutlet weak var imageViewMinMaxLengh: UIImageView!
    @IBOutlet weak var buttonReEnterPin: BaseButton!
    // MARK: Properties
    var presenter: RegisterPinPresenterProtocol?
    var otpInputCode = String()
    var pinTypeEnum = PinSecurity.weakPin
    var isPasswordHide = true
    var checkPin = [String:Bool]()
    var userJourneyEnum = UserJourneyFlow.onboarding
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.presenter == nil {
            _ = RegisterPinRouter.setupModule(vc: self)
        } else {
            print("presenter was not nil")
        }
        
        
        setViewInterface()
        
        self.keyboardCallBack = {[weak self] (isHidden, frame) in
            if isHidden {
                self?.setScreenSize(size: .halfScreen)
            } else {
                self?.setScreenSize(size: .fullScreen)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setScreenSize(size: .halfScreen)
    }
    
    func getLangPack(selectedLang: String) {
        Loader.shared.showFullScreen()
        Task {
            let isSuccess = await LocaleManager.shared.getLanguagePackFromServer(langCode: selectedLang)
            DispatchQueue.main.async {
                Loader.shared.hideFullScreen()
                if isSuccess{
                    UserDefaultHelper.isLangSelected = true
                    LocaleManager.setAppleLanguageTo(selectedLang)
                        self.setViewInterface()
                }else{
                    Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: Strings.Generic.generalErrorMsg)
                }
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Setting View Interface
    func setViewInterface(){
        self.isHideNavigation(false)
        self.createNavBackBtn()
        
        switch userJourneyEnum {
        case .onboarding:
            self.viewStepper.isHidden = false
            self.navigationItem.setTitle(title: "register".localized,subtitle: "set_your_new_pin".localized)
            labelSecureAccount.text = "create_pin".localized
        case .forgotPin :
            self.viewStepperTopConstraint.constant = 0
            self.viewStepper.isHidden = true
            labelSecureAccount.text = "use_this_pin".localized
            self.navigationItem.setTitle(title: "forgot_pin_statement".localized,subtitle: "set_your_new_pin".localized)
        case .registerDevice:
            print("This case will not be handled here")
        }
        setFontsAndText()
        if GlobalData.shared.isSingleAccount {
            viewStepper.addRedLine(noOfSteps: 2, currentStep: 2)
        }else{
            if GlobalData.shared.registrationType == .noKyc {
                viewStepper.addRedLine(noOfSteps: 2, currentStep: 2)
            }
            else {
                viewStepper.addRedLine(noOfSteps: 4, currentStep: 4)
            }
           
        }
        configureOtpField()
        checkPin.updateValue(false, forKey: "repeat")
        checkPin.updateValue(false, forKey: "consecutive")
        checkPin.updateValue(false, forKey: "isBirthYear")
        setIsPasswordHide(passwordHide: isPasswordHide)
        
        self.updateBottomBtnConstraintOnKeyboardAppearing(self.constraintButtonBottom, bottomPadding: 32)
        
        imageViewMinMaxLengh.image = UIImage(named:"slash-black")
        imageViewConsecutiveNum.image = UIImage(named:"slash-black")
        imageViewRepeatNum.image = UIImage(named:"slash-black")
        imageViewAvoidDob.image = UIImage(named:"slash-black")
    }
    func setFontsAndText(){
        
        labelSecureAccount.textColor = AppColor.eAnd_Black_80
        labelSecureAccount.font = AppFont.appRegular(size: .body2)
        
        
        self.textFieldOtp.title = "enter_pin".localized
        self.textFieldOtp.state = .normal
        self.textFieldOtp.textFieldFont = AppFont.appRegular(size: .h7)
        self.textFieldOtp.textFieldTextColor = AppColor.eAnd_Black_80
        self.textFieldOtp.entryType = .numberPad
        self.textFieldOtp.state = .normal
        
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
        
        labelHide.text = "show".localized
        labelHide.textColor = AppColor.eAnd_Red_100
        labelHide.font = AppFont.appMedium(size: .body4)
        
        labelWeakPin.text = "weak_pin".localized
        labelWeakPin.textColor = AppColor.eAnd_Red_100
        labelWeakPin.font = AppFont.appMedium(size: .body4)
        setStateOnNoInput()
        self.buttonReEnterPin.disable()
    }
    
    func setStateOnNoInput(){
        labelWeakPin.isHidden = true
        imageViewWeak.isHidden = true
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
            self.imageViewWeak.image = UIImage(named:"info-circle-red")
            labelWeakPin.textColor = AppColor.eAnd_Red_100
        case .strongPin:
            labelWeakPin.textColor = AppColor.greenSuccessHex
            self.labelWeakPin.text = "strong_pin".localized
            self.imageViewWeak.image = UIImage(named:"tick-circle")
        case .average:
            self.labelWeakPin.text = "average_pin".localized
            self.imageViewWeak.image = UIImage(named:"info-circle")
            labelWeakPin.textColor = AppColor.eAnd_Warning_100
        }
        labelWeakPin.isHidden = false
        imageViewWeak.isHidden = false
    }
    
    func checkIfBirthYear(otpPin : String) -> Bool {
        if otpPin.count > 3  {
            
            let year = Calendar.current.component(.year, from: Date())
            let hundredYears = Int("1923") ?? 0
            let pinInt = Int(otpPin) ?? 0
            let otpReverse = String(otpPin.reversed())
            let pinReverseInt = Int(otpReverse) ?? 0
            
            
            let numberRange = hundredYears...year
            if numberRange.contains(pinInt) {
                return true
            }
            if numberRange.contains(pinReverseInt ?? 0) {
                return true
            } else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    
    private func setupTextFieldDelegates() {
        textFieldOtp.textChangedCallback = {
            //self.validateOtpText(code:self.textFieldOtp.text)
            self.validatePin(self.textFieldOtp.text)
        }
    }
    
    func configureOtpField() {
        self.textFieldOtp.entryType = .numberPad
        self.textFieldOtp.textLimit = 8
        setupTextFieldDelegates()
    }
    
    func setIsPasswordHide(passwordHide : Bool){
        if passwordHide {
            labelHide.text = "show".localized
            labelHide.textColor = AppColor.eAnd_Error_100
            labelHide.font = AppFont.appRegular(size: .body4)
            imageViewHide.image = UIImage(named:"eye")
            self.textFieldOtp.isSecureTextEntry = true
        }
        else {
            labelHide.text = "hide".localized
            labelHide.textColor = AppColor.eAnd_Error_100
            labelHide.font = AppFont.appRegular(size: .body4)
            imageViewHide.image = UIImage(named:"eye-slash")
            self.textFieldOtp.isSecureTextEntry = false
        }
    }
    
    
    func validatePin(_ inputStr: String){
        // Rule 1: Check if the string length is between 4 and 8 characters.
        if inputStr.count < 4 {
            imageViewMinMaxLengh.image = UIImage(named:"slash")
            imageViewConsecutiveNum.image = UIImage(named:"slash-black")
            imageViewRepeatNum.image = UIImage(named:"slash-black")
            imageViewAvoidDob.image = UIImage(named:"slash-black")
            self.buttonReEnterPin.disable()
            
            if inputStr.isEmpty {
                imageViewMinMaxLengh.image = UIImage(named:"slash-black")
                setStateOnNoInput()
            }
            return
        }else{
            self.buttonReEnterPin.enable()
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
            self.buttonReEnterPin.disable()
        }else{
            imageViewAvoidDob.image = UIImage(named:"tick-circle")
            checkPin.updateValue(false, forKey: "isBirthYear")
            self.buttonReEnterPin.enable()
        }
        setPinStrength(dictionary: checkPin)
        
        self.otpInputCode = inputStr
    }
    
    // MARK: IB Actions
    @IBAction func buttonReEnterPinTapped(_ sender: Any) {
        view.endEditing(true)
        presenter?.navigateToReEnterPin(pin: self.otpInputCode, flowEnum: userJourneyEnum)
    }
    
    @IBAction func buttonShowHideTapped(_ sender: Any) {
        isPasswordHide = !isPasswordHide
        setIsPasswordHide(passwordHide: isPasswordHide)
    }
}

extension RegisterPinViewController: RegisterPinViewProtocol {
    
}
