//
//  OtpForgotPinPopupViewController.swift
//  e&money
//
//  Created by Qamar Iqbal on 22/06/2023.
//  
//

import Foundation
import UIKit

class OtpForgotPinPopupViewController: BaseViewController {

    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var textFieldOtp: OTPTextField!
    @IBOutlet weak var labelOtpNumber: UILabel!
    @IBOutlet weak var labelHaventRecieve: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var buttonResendOtp: UIButton!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
//    var delegate: OtpForgotPinPopupDelegate?
    var presenter: OtpForgotPinPopupPresenterProtocol?
    var otpInputCode = String()
    var timer : Timer?
    var verifyCount = 0
    var delegate : SendDataSDK?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        delegate?.sendStringData(string: "forgot_pin")
        keyboardCallBack = {[weak self] (isHidden, _) in
            if isHidden {
                self?.delegate?.changeScreenSize(size: .halfScreen, viewHeight: 0)
            }else {
                self?.delegate?.changeScreenSize(size: .fullScreen, viewHeight: 0)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        TimerOtp.shared.stopTimer()
    }
    
    func setupModule() {
        let presenter = OtpForgotPinPopupPresenter()
        let router = OtpForgotPinPopupRouter()
        let interactor = OtpForgotPinPopupInteractor()
        self.presenter =  presenter
        presenter.view = self
        presenter.router = router
        presenter.interactor = interactor
        router.view = self
        interactor.output = presenter
    }
    
    func setUpUI() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.backGroundView.addGestureRecognizer(tapGesture)
        
        self.isHideNavigation(false)
        self.navigationItem.setTitle(title:"forgot_pin_statement".localized,subtitle: "enter_otp".localized)
//        self.createNavCloseBtn()
        self.presenter?.getTokenRequestFromServer()
        TimerOtp.shared.delegate = self
        IQKeyboardManager.shared.enable = true
        labelOtpNumber.text = Strings.AddMoney.enterOTPEmail
        
        labelOtpNumber.font = AppFont.appRegular(size: .body2)
        labelOtpNumber.textColor = AppColor.eAnd_Black_80
        
        labelHaventRecieve.text = Strings.AddMoney.haventReceived
        labelHaventRecieve.textColor = AppColor.eAnd_Black_80
        labelHaventRecieve.font = AppFont.appRegular(size: .body4)
        
        buttonResendOtp.setTitle(Strings.AddMoney.resendOtp, for: .normal)
        buttonResendOtp.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        buttonResendOtp.titleLabel?.font = AppFont.appMedium(size: .body4)
        buttonResendOtp.isUserInteractionEnabled = false

        configureOtpField()
        
        self.updateBottomBtnConstraintOnKeyboardAppearing(viewBottomConstraint, bottomPadding: 0)
//        self.addSwipeDown(on: self.viewPopup)
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
            GlobalData.shared.otp = otpCode
            self?.presenter?.navigateSetPin()
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

        let doneButton = UIBarButtonItem(title: "done_btn_text".localized, style: .done, target: self,
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
    
//    func timerStart(remainingTimer: Int? = nil){
//        TimerOtp.shared.stopTimer()
//        timerCountStart(remainingTimer: remainingTimer)
//        verifyCount = 0
//    }
    
    func timerStart() {
        TimerOtp.shared.stopTimer()
        timerCountStart()
        verifyCount = 0
    }

    @IBAction func ResendOtpBtnTapped(_ sender: Any) {
        self.presenter?.checkotpSendRequestResponse()
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        print("Dismiss view")
        self.presenter?.dismissView()
    }
}

// MARK: Delegates
extension OtpForgotPinPopupViewController: OtpForgotPinPopupViewProtocol {
//    func otpSendRequestResponse(response: VerifyMobileNumberResponseModel) {
//        Loader.shared.hideFullScreen()
//        if response.data?.isBlocked ?? false {
//            presenter?.`navigateToFailedOtp`(model: response)
//        }
//        else {
//            self.timerStart()//(remainingTimer: response.data?.remainingReattemptTimeInSeconds)
//            self.setError(with: "", isError: false)
//        }
//    }
//    
//    func otpSendError(error: AppError) {
//        Loader.shared.hideFullScreen()
//        currentCount(counter: -1)
//        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
//    }
//    
//    func initiatePinRequestResponse(response: InitiatePinResponseModel) {
//        Loader.shared.hideFullScreen()
//        verifyCount = 0
//    }
    
//    func otpVerifyRequestResponse(response: VerifyMobileNumberResponseModel) {
//        SDKColors.shared.onSuccess?("\(#function) with response \(response)")
//        Loader.shared.hideFullScreen()
//        delegate?.otpPopupDidDismiss()
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    func verifyMobileRequestResponseError(error: AppError) {
//        SDKColors.shared.onFailure?("\(error.errorCode)", "\(error.localizedDescription)")
//        Loader.shared.hideFullScreen()
//        if error.errorCode != "1" {
//            Alert.showBottomSheetError(title: error.errorDescription, message: "")
//        } else {
//            verifyCount += 1
//            self.setError(with: error.errorDescription, isError: true)
//        }
//    }
    
    func forgetPinOtpSendRequestResponse(response: VerifyMobileNumberResponseModel) {
        Loader.shared.hideFullScreen()
        labelOtpNumber.text = Strings.AddMoney.enterOTPEmail + " \(response.data?.email ?? "")"
        if response.data?.isBlocked ?? false {
            presenter?.`navigateToFailedOtp`(model: response)
        } else {
            self.timerStart()
            self.setError(with: "", isError: false)
        }
    }
    
    func forgetPinOtpSendError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: error.errorDescription, message: "")
        currentCount(counter: -1)
    }
}


extension OtpForgotPinPopupViewController: TimerProtocol {
    
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
