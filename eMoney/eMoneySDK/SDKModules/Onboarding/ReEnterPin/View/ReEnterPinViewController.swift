//
//  ReEnterPinViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/04/2023.
//  
//

import Foundation
import UIKit
import LocalAuthentication

class ReEnterPinViewController: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var viewStepperTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var constraintBottomButton: NSLayoutConstraint!
    @IBOutlet weak var viewEnableFace: UIView!
    @IBOutlet weak var labelReEnterPin: UILabel!
    @IBOutlet weak var textFieldOtp: StandardTextField!
    @IBOutlet weak var labelPinMismatch: UILabel!
    @IBOutlet weak var buttonSetPin: BaseButton!
    @IBOutlet weak var viewStepper: BaseStepper!
    @IBOutlet weak var imageViewEnableId: UIImageView!
    @IBOutlet weak var imageViewHide: UIImageView!
    @IBOutlet weak var labelHide: UILabel!
    @IBOutlet weak var labelFaceId: UILabel!
    // MARK: Properties
    
    var presenter: ReEnterPinPresenterProtocol?
    var pinPassword = String()
    var otpInputCode = String()
    var isIdSelect = false
    var isPasswordHide = true
    var userJourneyEnum = UserJourneyFlow.onboarding
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//https://uat-swypapp.etisalat.ae/mwallet-rest/api/pin/reset
    // MARK: Setting View Interface
    func setViewInterface(){
        self.isHideNavigation(false)
        self.createNavBackBtn()
        self.imageViewEnableId.image = UIImage(named:"defaultCheckbox")
        self.viewEnableFace.isHidden = false
        
        switch userJourneyEnum {
        case .onboarding :
            self.navigationItem.setTitle(title: "register".localized,subtitle: "re_enter_pin_title".localized)
            labelReEnterPin.text = "re_enter_pinsave".localized
            buttonSetPin.setTitle("set_pin_btn_text".localized, for: .normal)
            self.viewStepper.isHidden = false
        case .forgotPin :
            self.navigationItem.setTitle(title: "forgot_pin_statement".localized,subtitle: "re_enter_pin_title".localized)
            labelReEnterPin.text = "use_this_pin".localized
            buttonSetPin.setTitle("set_pin_btn_text".localized, for: .normal)
            self.viewEnableFace.isHidden = true
            self.viewStepperTopConstraint.constant = 0
            self.viewStepper.isHidden = true
        }
        
        self.labelPinMismatch.isHidden = true
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
    
        self.textFieldOtp.title = "re_enter_pin_title".localized
        self.textFieldOtp.state = .normal
        self.textFieldOtp.textFieldFont = AppFont.appRegular(size: .h7)
        self.textFieldOtp.textFieldTextColor = AppColor.eAnd_Black_80
        self.textFieldOtp.entryType = .numberPad
        self.textFieldOtp.state = .normal

        setIsPasswordHide(passwordHide: isPasswordHide)
        self.updateBottomBtnConstraintOnKeyboardAppearing(self.constraintBottomButton, bottomPadding: 32)
    }
    func setFontsAndText(){
        labelReEnterPin.textColor = AppColor.eAnd_Black_80
        labelReEnterPin.font = AppFont.appRegular(size: .body2)
        
        labelPinMismatch.text = "pin_mismatch".localized
        labelPinMismatch.textColor = AppColor.eAnd_Error_100
        labelPinMismatch.font = AppFont.appRegular(size: .body4)
        labelPinMismatch.isHidden = true
        
        labelHide.text = "show".localized
        labelHide.textColor = AppColor.eAnd_Error_100
        labelHide.font = AppFont.appRegular(size: .body4)
        
        labelFaceId.text = "enable_face_id_touch_id".localized
        labelFaceId.textColor = AppColor.eAnd_Black_80
        labelFaceId.font = AppFont.appRegular(size: .body4)
        self.buttonSetPin.disable()
        
    }
    
    func configureOtpField() {
        self.textFieldOtp.entryType = .numberPad
        self.textFieldOtp.textFieldFont = AppFont.appRegular(size: .h7)
        self.textFieldOtp.textFieldTextColor = AppColor.eAnd_Black_80
        self.textFieldOtp.textLimit = 8
        self.textFieldOtp.state = .normal
        setupTextFieldDelegates()
    }
    private func setupTextFieldDelegates() {
        textFieldOtp.textChangedCallback = {
            self.buttonEnableDisable(code: self.textFieldOtp.text)
            self.labelPinMismatch.isHidden = true
            //self.validateOtpPin(otpCode: self.textFieldOtp.text)
        }
    }
    
    // MARK: Enable Face Touch Id
    
    func enableFaceTouchId() {
        let context = LAContext()
        var error: NSError?
      
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "enable_face".localized
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.presenter?.callRegistrationApi(pin: self?.textFieldOtp.text ?? "", isBiomatricEnabled: true)
                    }
                    else if let error = error as? LAError{
                        switch error.code{
                        case .touchIDNotEnrolled,.biometryNotEnrolled :
                            CommonMethods.openSettingsForFaceId(title: "face_enroll".localized, message: "face_enroll_message".localized)
                        default:
                            Alert.showBottomSheetError(title: "auth_failed", message: "auth_failed_verify")
                        }
                    }
                    else {
                        Alert.showBottomSheetError(title: "auth_failed", message: "auth_failed_verify")
                    }
                }
            }
        } else {
            Alert.showBottomSheetError(title: "biometry_unavailable".localized, message: "device_error_biometry".localized)
        }
    }
    
    func showAlert(title:String,message : String, action :String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: { _ in
            //self.presenter?.navigateToNotificationScreen()
        }))
        self.present(ac, animated: true)
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
    
    func buttonEnableDisable(code : String) {
        if code.count > 3 {
            self.buttonSetPin.enable()
        }
        else {
            self.buttonSetPin.disable()
        }
    }
    func resetApiCall(){
        guard let encryptOtp = try? GlobalData.shared.otp?.aesEncrypt(key:EncryptionKey.pinKey) else {return}
        let obj = ResetPinRequestModel()
        obj.repeatNewPin = textFieldOtp.text
        obj.newPin = self.pinPassword
        obj.otp = encryptOtp
        obj.pin = ""
        obj.flowName = "Upgrade"
        obj.transactionId = "971549996938-02364892152"
        obj.credentialType = "pincode"
        presenter?.callResetApi(resetPinObj: obj)
    }
    func setFlowJourney(){
        switch userJourneyEnum {
        case .onboarding :
            if isIdSelect {
                enableFaceTouchId()
            }
            else {
                presenter?.callRegistrationApi(pin: textFieldOtp.text, isBiomatricEnabled: false)
            }
        case .forgotPin :
           resetApiCall()
        }
    }
    
    // MARK: IB Actions
    @IBAction func buttonEnableIdTapped(_ sender: Any) {
        
        self.imageViewEnableId.image = UIImage(named:"defaultCheckbox")
        isIdSelect = !isIdSelect
        if isIdSelect {
            self.imageViewEnableId.image = UIImage(named:"redCheckbox")
        }
    }
    @IBAction func buttonHideShowTapped(_ sender: Any) {
        isPasswordHide = !isPasswordHide
        setIsPasswordHide(passwordHide: isPasswordHide)
    }
    @IBAction func buttonSetPinTapped(_ sender: Any) {
        view.endEditing(true)
        let isValid = validateOtpPin(otpCode: self.textFieldOtp.text)
        if isValid {
            setFlowJourney()
        }
    }
}

extension ReEnterPinViewController: ReEnterPinViewProtocol {
    func resetPinRequestResponse(response: ResetPinResponseModel) {
        print(response)
        presenter?.navigateSuccess()
    }
    
    func onResetRequestError(error: AppError) {
        print(error)
       
        Alert.showBottomSheetError(title: "forget_pin_error".localized, message: error.errorDescription.localized, actionBtnTitle: "try_again".localized,imageIconError:"danger", delegate: self)
    }

}

extension ReEnterPinViewController: GeneralBottomSheetErrorViewDelegate {
    func tryAgainBtnTapped(index: Int) {
        if userJourneyEnum == .forgotPin {
            //resetApiCall()
        }
    }
    func closeBtnTapped() {
        
    }
    
}
