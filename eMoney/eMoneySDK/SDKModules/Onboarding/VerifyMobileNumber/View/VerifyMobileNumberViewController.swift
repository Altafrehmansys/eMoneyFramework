//
//  VerifyMobileNumberViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation
import UIKit

class VerifyMobileNumberViewController: BaseViewController {
    // MARK: Outlets
    @IBOutlet weak var textfieldOtp: OTPTextField!
    
    @IBOutlet weak var constraintBottomButton: NSLayoutConstraint!
    @IBOutlet weak var labelNotRecieve: UILabel!
    @IBOutlet weak var labelResendOtp: UILabel!
    @IBOutlet weak var labelOTP: UILabel!
    
    @IBOutlet weak var labelEmailID: UILabel!
    
    @IBOutlet weak var buttonResendOtp: UIButton!
    @IBOutlet weak var buttonConfirm: BaseButton!
    
    var delegate: SendDataSDK?
    
    // MARK: Properties
    var presenter: VerifyMobileNumberPresenterProtocol?
    var msisdn = String()
    var isNumberChange = false
    var otpInputCode = String()
    var timer : Timer?
    var userJourneyEnum = UserJourneyFlow.onboarding
    var verifyCount = 0
    var currentCount = 0
    var currentDate = Date()
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUserInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.delegate?.sendStringData(string: "Verify")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.delegate?.changeScreenSize(size: .fullScreen)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name:UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        
    }
    // MARK: Setting View
    func setViewUserInterface() {
        self.isHideNavigation(false)
        switch userJourneyEnum {
        case .forgotPin :
            labelEmailID.isHidden = true
            self.navigationItem.setTitle(title: "forgot_pin_statement".localized,subtitle: "enter_otp".localized)
            let otpSentence = "otp_sent_email".localized
            labelOTP.text = otpSentence
            self.presenter?.initiatePinRequest(resend: false, questionSkip: false, unblock: false)
            //self.timerStart()
        case .onboarding :
            labelEmailID.isHidden = true
            self.navigationItem.setTitle(title: "register".localized,subtitle: "verify_mobile_number".localized)
            let otpSentence = "enter_otp_number".localized + " " + CommonMethods.getFormattedStringForPhoneNumberWithCode(phoneNumber: "+\(msisdn)")
            labelOTP.text = otpSentence
            if isNumberChange {
                timerStartFromScratch()
            }
            else {
                timerResume()
            }
        }
        
        labelResendOtp.text = "resend_otp".localized
        
        labelNotRecieve.text = "havent_received".localized
        self.buttonConfirm.setTitle("confirm_btn_text".localized, for: .normal)
        labelNotRecieve.textColor = AppColor.eAnd_Black_80
        labelEmailID.textColor = AppColor.eAnd_Black_80
        labelEmailID.font = AppFont.appSemiBold(size: .body2)
        self.labelResendOtp.textAlignment = .right
        self.buttonConfirm.disable()
        
        self.createNavBackBtn()
        self.labelResendOtp.textColor = AppColor.eAnd_Grey_100
        self.labelResendOtp.font = AppFont.appMedium(size: .body4)
        self.labelNotRecieve.textColor = AppColor.eAnd_Black_80
        self.labelNotRecieve.font = AppFont.appRegular(size: .body4)
        
        
        configureOtpField()
        self.buttonResendOtp.isUserInteractionEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        self.updateBottomBtnConstraintOnKeyboardAppearing(self.constraintBottomButton, bottomPadding: 32)
    }
    
    func showEmailInMasking(response: VerifyMobileNumberResponseModel){
        if let email = response.data?.email{
            labelEmailID.isHidden = false
            labelEmailID.text = email
        }
    }
    
    func timerStartFromScratch(){
        TimerOtp.shared.stopTimer()
        if TimerOtp.shared.timeCounter == 0 {
            self.presenter?.checkotpSendRequestResponse()
        }
        
    }
    func timerResume(){
        if TimerOtp.shared.timeCounter == 0 || GlobalData.shared.isVerified {
            self.presenter?.checkotpSendRequestResponse()
        }
        else {
            TimerOtp.shared.delegate = self
            TimerOtp.shared.timerResume()
        }
        
    }
    
    @objc func appMovedToBackground() {
        print(currentCount)
        currentDate = Date()
        print("App moved to background!")
    }
    @objc func appBecomeActive() {
        print("App become active")
        let elapsed = Date().timeIntervalSince(currentDate)
        let duration = Int(elapsed)
        print(duration)
        currentCount = currentCount - duration
        TimerOtp.shared.timeCounter = currentCount
        timerResume()
    }
    
    func configureOtpField() {
        let configuration = OTPFieldConfiguration(adapter: PinFieldAdapter(viewType: .otpPin),
                                                  keyboardType: .numberPad,
                                                  keyboardAppearance: .light,
                                                  autocorrectionType: .no)
        textfieldOtp.setConfiguration(configuration)
        textfieldOtp.onOTPEnter = { [weak self] otpCode in
            self?.otpInputCode = otpCode
            
        }
        textfieldOtp.onTextChanged = { [weak self] code in
            if code?.count ?? 0 > 3 {
                self?.buttonConfirm.enable()
            }
            else {
                self?.buttonConfirm.disable()
            }
            self?.setError(isError: false)
        }
        
        addToolbar()
    }
    
    func addToolbar(){
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self,
                                         action: #selector(textFieldDonePressed))
        doneButton.tintColor = .blue
        
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textfieldOtp.inputAccessoryView = toolBar
    }
    
    @objc func textFieldDonePressed() {
        //Done with number pad
        self.view.endEditing(true)
    }
    
    func setError(isError:Bool,errMsg:String? = nil) {
        if isError || verifyCount == 3 {
            self.textfieldOtp.setError()
            self.labelNotRecieve.text = errMsg//"otp_invalid".localized
            self.labelNotRecieve.textColor = AppColor.eAnd_Error_100
            self.buttonConfirm.disable()
        }else{
            self.textfieldOtp.removeError()
            self.labelNotRecieve.text = "havent_received".localized
            self.labelNotRecieve.textColor = AppColor.eAnd_Black_80
        }
    }
    
    func timerCountStart(){
        let count = TimerOtp.shared.startTimer()
        TimerOtp.shared.delegate = self
    }
    
    func navigateToTimer(modelOtp : VerifyMobileNumberResponseModel){
        presenter?.navigateToFailedOtp(model: modelOtp)
    }
    func timerStart(){
        TimerOtp.shared.stopTimer()
        timerCountStart()
        verifyCount = 0
    }
    // MARK: IB Actions
    @IBAction func buttonConfirmTapped(_ sender: Any) {
        view.endEditing(true)
        switch userJourneyEnum {
        case .onboarding :
            self.presenter?.verifyOtpRequestResponse(otp: otpInputCode, flowType: .onboarding)
        case .forgotPin :
            GlobalData.shared.otp = otpInputCode
            self.presenter?.navigateToRegisterPin(otp: otpInputCode)
            // self.presenter?.verifyOtpRequestResponse(otp: otpInputCode, flowType: .forgotPin)
        }
    }
    
    @IBAction func buttonResendOtpTapped(_ sender: Any) {
        self.setError(isError: false)
        if userJourneyEnum == .forgotPin {
            self.presenter?.initiatePinRequest(resend: false, questionSkip: false, unblock: false)
        }else{
            self.presenter?.checkotpSendRequestResponse()
        }
    }
    
}

// MARK: Delegates
extension VerifyMobileNumberViewController: VerifyMobileNumberViewProtocol {
    func otpSendRequestResponse(response: VerifyMobileNumberResponseModel) {
        if response.data?.isBlocked ?? false {
            navigateToTimer(modelOtp: response)
        }
        else {
            self.timerStart()
        }
    }
    
    func otpSendError(error: AppError) {
        currentCount(counter: -1)
    }
    
    func initiatePinRequestResponse(response: VerifyMobileNumberResponseModel) {
        verifyCount = 0
        if response.data?.isBlocked ?? false {
            navigateToTimer(modelOtp: response)
        }
        else {
            self.timerStart()
            showEmailInMasking(response: response)
        }
    }
    
    func otpVerifyRequestResponse(response: VerifyMobileNumberResponseModel) {
        SDKColors.shared.onSuccess?("\(#function) with response \(response)")
        print(response)
    }
    
    func verifyMobileRequestResponseError(error: AppError) {
        verifyCount += 1
        self.setError(isError: true,errMsg: error.errorDescription)
        SDKColors.shared.onFailure?("\(error.errorCode)", "\(error.localizedDescription)")
        // Alert.showError(title: "", message: error.errorDescription)
        //Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
    }
    
    
}
extension VerifyMobileNumberViewController: TimerProtocol {
    func currentCount(counter: Int) {
        if counter >= 0 {
            var stringResult = "(\(counter)s)" + " " + "resend_otp".localized
            if counter == 0 {
                stringResult = "resend_otp".localized
            }
            let otpText = stringResult
            currentCount = counter
            
            self.labelResendOtp .text = otpText
            self.buttonResendOtp.isUserInteractionEnabled = false
            self.labelResendOtp.textColor = AppColor.eAnd_Grey_100
        } else {
            self.buttonResendOtp.isUserInteractionEnabled = true
            currentCount = counter
            self.labelResendOtp.textColor = AppColor.eAnd_Red_100
            
        }
    }
    func counterEnd() {
        TimerOtp.shared.stopTimer()
        self.buttonResendOtp.isUserInteractionEnabled = true
        
        self.labelResendOtp.textColor = AppColor.eAnd_Red_100
    }
}
