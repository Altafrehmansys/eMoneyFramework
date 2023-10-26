//
//  OtpPopupViewController.swift
//  e&money
//
//  Created by Qamar Iqbal on 22/06/2023.
//  
//

import Foundation
import UIKit

class OtpPopupViewController: BaseViewController {

    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var textFieldOtp: OTPTextField!
    @IBOutlet weak var labelOtpNumber: UILabel!
    @IBOutlet weak var labelHaventRecieve: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPaying: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var labelNameView: UIView!
    @IBOutlet weak var labelPayingView: UIView!
    
    @IBOutlet weak var buttonResendOtp: UIButton!
    @IBOutlet weak var amountField: BaseAmountField!
    
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    var delegate: OtpPopupDelegate?
    var userJourney: UserJourneyFlow? = nil
    var presenter: OtpPopupPresenterProtocol?
    var otpInputCode = String()
    var timer : Timer?
    var verifyCount = 0
    
    override func viewDidLoad() {
       super.viewDidLoad()
       setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        TimerOtp.shared.stopTimer()
    }
    
    func setUpUI() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.backGroundView.addGestureRecognizer(tapGesture)
        
        self.isHideNavigation(false)

        if TimerOtp.shared.timeCounter == 0 {
//            SDKColors.shared.flowName == ""
            self.presenter?.checkotpSendRequestResponse()
        }
        TimerOtp.shared.delegate = self
        
        if userJourney == .forgotPin {
            labelOtpNumber.text = Strings.AddMoney.enterOTPEmail
        } else {
            let formatedPhoneNumber = CommonMethods.getFormattedStringForPhoneNumberWithCode(phoneNumber: SDKColors.shared.msisdn ?? "")
            let otpSentence = Strings.AddMoney.enterOTPNumber + formatedPhoneNumber
            labelOtpNumber.text = otpSentence
        }
        
        labelOtpNumber.font = AppFont.appRegular(size: .body2)
        labelOtpNumber.textColor = AppColor.eAnd_Black_80
        labelOtpNumber.isHidden = userJourney == .forgotPin
        
        labelNameView.isHidden = userJourney == .forgotPin
        labelPayingView.isHidden = userJourney == .forgotPin
        amountField.isHidden = userJourney == .forgotPin
        
        labelPaying.text = presenter?.addingText
        labelPaying.font = AppFont.appRegular(size: .body4)
        labelPaying.textColor = AppColor.eAnd_Grey_100
        
        labelName.text = presenter?.toTitle
        labelName.font = AppFont.appRegular(size: .body4)
        labelName.textColor = AppColor.eAnd_Grey_100
        
        amountField.isUserInteractionEnabled = false
        amountField.currentColor = AppColor.eAnd_Black_80
        amountField.settingView(desc: "")
        amountField.text = presenter?.amount
        
        labelHaventRecieve.text = Strings.AddMoney.haventReceived
        labelHaventRecieve.textColor = AppColor.eAnd_Black_80
        labelHaventRecieve.font = AppFont.appRegular(size: .body4)
        
        buttonResendOtp.setTitle(Strings.AddMoney.resendOtp, for: .normal)
        buttonResendOtp.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        buttonResendOtp.titleLabel?.font = AppFont.appMedium(size: .body4)
        buttonResendOtp.isUserInteractionEnabled = false

        configureOtpField()
        
        self.updateBottomBtnConstraintOnKeyboardAppearing(viewBottomConstraint, bottomPadding: 0)
        self.addSwipeDown(on: self.viewPopup)
    }
    
    func configureOtpField() {
        let configuration = OTPFieldConfiguration(adapter: PinFieldAdapter(viewType: .otpPin),
                                                  keyboardType: .numberPad,
                                                  keyboardAppearance: .light,
                                                  autocorrectionType: .no)
        textFieldOtp.setConfiguration(configuration)
        textFieldOtp.onOTPEnter = { [weak self] otpCode in
            if self?.verifyCount == 3 {
                return
            }
            self?.otpInputCode = otpCode
            
            if self?.userJourney == .forgotPin {
                GlobalData.shared.otp = otpCode
                self?.presenter?.navigateSetPin()
            } else {
                self?.presenter?.verifyOtpRequestResponse(otp: self?.otpInputCode ?? "")
            }
        }
        
       addToolbar()
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
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

        textFieldOtp.inputAccessoryView = toolBar
    }
    
    @objc func textFieldDonePressed() {
        self.view.endEditing(true)
    }
    
    func setError(with message: String, isError: Bool) {
        if isError || verifyCount == 3 {
            self.textFieldOtp.setError()
            self.labelHaventRecieve.text = message
            self.labelHaventRecieve.textColor = AppColor.eAnd_Error_100
        }else{
            self.textFieldOtp.clear()
            self.textFieldOtp.removeError()
            self.labelHaventRecieve.text = Strings.AddMoney.haventReceived
            self.labelHaventRecieve.textColor = AppColor.eAnd_Black_80
        }
    }
   
    func timerCountStart(remainingTimer: Int? = nil) {
        if let remainingTimer {
            TimerOtp.shared.startTimer(time: remainingTimer)
        } else {
            TimerOtp.shared.startTimer()
        }
        TimerOtp.shared.delegate = self
    }
    
    func timerStart(remainingTimer: Int? = nil){
        TimerOtp.shared.stopTimer()
        timerCountStart(remainingTimer: remainingTimer)
        verifyCount = 0
    }

    @IBAction func ResendOtpBtnTapped(_ sender: Any) {
        self.presenter?.checkotpSendRequestResponse()
    }
    
}

// MARK: Delegates
extension OtpPopupViewController: OtpPopupViewProtocol {
    func otpSendRequestResponse(response: VerifyMobileNumberResponseModel) {
        Loader.shared.hideFullScreen()
        if response.data?.isBlocked ?? false {
            presenter?.`navigateToFailedOtp`(model: response)
        }
        else {
            self.timerStart(remainingTimer: response.data?.remainingReattemptTimeInSeconds)
            self.setError(with: "", isError: false)
        }
    }
    
    func otpSendError(error: AppError) {
        Loader.shared.hideFullScreen()
        currentCount(counter: -1)
        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
    }
    
    func initiatePinRequestResponse(response: InitiatePinResponseModel) {
        Loader.shared.hideFullScreen()
        verifyCount = 0
    }
    
    func otpVerifyRequestResponse(response: VerifyMobileNumberResponseModel) {
        SDKColors.shared.onSuccess?("\(#function) with response \(response)")
        Loader.shared.hideFullScreen()
        delegate?.otpPopupDidDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    func verifyMobileRequestResponseError(error: AppError) {
        SDKColors.shared.onFailure?("\(error.errorCode)", "\(error.localizedDescription)")
        Loader.shared.hideFullScreen()
        if error.errorCode != "1" {
            Alert.showBottomSheetError(title: error.errorDescription, message: "")
        } else {
            verifyCount += 1
            self.setError(with: error.errorDescription, isError: true)
        }
    }
    
    func forgetPinOtpSendRequestResponse(response: VerifyMobileNumberResponseModel) {
        labelOtpNumber.text = Strings.AddMoney.enterOTPEmail + " \(response.data?.email ?? "")"
    }
    
    func forgetPinOtpSendError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: error.errorDescription, message: "")
    }
}


extension OtpPopupViewController: TimerProtocol {
    
    func currentCount(counter: Int) {
        if counter >= 0 {
            var stringResult = "(\(counter)s)" + " " + Strings.AddMoney.resendOtp
            if counter == 0 {
                stringResult = Strings.AddMoney.resendOtp
            }
            let otpText = stringResult
            
            buttonResendOtp.setTitle(otpText, for: .normal)
            buttonResendOtp.setTitleColor(AppColor.eAnd_Grey_100, for: .normal)
            buttonResendOtp.isUserInteractionEnabled = false
        } else {
            buttonResendOtp.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
            buttonResendOtp.isUserInteractionEnabled = true
        }
    }
    
    
    func counterEnd() {
        TimerOtp.shared.stopTimer()
        buttonResendOtp.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        buttonResendOtp.isUserInteractionEnabled = true
    }
    
}
