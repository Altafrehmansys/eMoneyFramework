//
//  RegisterEmailViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 19/04/2023.
//  
//

import Foundation
import UIKit

class RegisterEmailViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var constraintBottomButton: NSLayoutConstraint!
    @IBOutlet weak var viewStepper: BaseStepper!
    @IBOutlet weak var labelVerifyLink: UILabel!
    @IBOutlet weak var txtFieldEmail: StandardTextField!
    @IBOutlet weak var buttonContinue: BaseButton!
    @IBOutlet weak var buttonNotNow: UIButton!
    // MARK: Properties

    var presenter: RegisterEmailPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
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
        setScreenSize(size: .halfScreen)
        NotificationCenter.default.post(name: .onChangeTopCloseButton, object: nil, userInfo: ["isShow":true])
    }
    func setViewInterface(){
        self.isHideNavigation(false)
        self.navigationItem.setTitle(title: "register".localized,subtitle: "enter_email".localized)
        if GlobalData.shared.isSingleAccount || GlobalData.shared.registrationType == .noKyc{
            viewStepper.addRedLine(noOfSteps: 2, currentStep: 1)
        }else{
            viewStepper.addRedLine(noOfSteps: 4, currentStep: 3)
        }
        
        setViewData()
        
        self.updateBottomBtnConstraintOnKeyboardAppearing(self.constraintBottomButton, bottomPadding: 32)
    }
    
    func setViewData(){
        labelVerifyLink.font = AppFont.appRegular(size: .body2)
        labelVerifyLink.textColor = AppColor.eAnd_Black_80
        labelVerifyLink.text = "we_will_send_link".localized
        buttonContinue.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        buttonContinue.setTitleColor(AppColor.eAnd_White, for: .normal)
        self.txtFieldEmail.title = "enter_email".localized
        self.txtFieldEmail.state = .normal
        self.buttonContinue.setTitle("continue_btn_text".localized, for: .normal)
        self.buttonNotNow.setTitle("not_now".localized, for: .normal)
        self.buttonNotNow.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        buttonNotNow.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        self.txtFieldEmail.textFieldFont = AppFont.appRegular(size: .body2)
        self.txtFieldEmail.textFieldTextColor = AppColor.eAnd_Black_80
        self.txtFieldEmail.entryType = .email
        self.txtFieldEmail.state = .normal
        self.createNavBackBtn()
       // self.buttonContinue.isUserInteractionEnabled = false
        self.buttonContinue.disable()
        //self.txtFieldEmail.text = "test@gmail.com"
        setupTextFieldDelegates()
        
    }
    
    private func setupTextFieldDelegates() {
        txtFieldEmail.textChangedCallback = {
            self.txtFieldEmail.hideError()
            self.buttonContinue.isUserInteractionEnabled = self.txtFieldEmail.text.isValidEmail
            if self.buttonContinue.isUserInteractionEnabled {
                self.buttonContinue.enable()
            }
            else {
                self.buttonContinue.disable()
            }
            //print("Text is changed, \(self.txtFieldEmail.text)")
        }
    }
    
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
       
    }
    
    
    // MARK: IB Actions
    @IBAction func buttonNotNowTapped(_ sender: Any) {
        presenter?.routeToRegisterPin()
    }
    
    @IBAction func buttonContinueTapped(_ sender: Any) {
        view.endEditing(true)
        presenter?.callVerifyEmail(email: self.txtFieldEmail.text)
    }
}

// MARK: Viper View Protocols
extension RegisterEmailViewController: RegisterEmailViewProtocol {
    func verifyEmailError(error: AppError) {
        txtFieldEmail.showError(with: error.errorDescription)
    }
}
extension RegisterEmailViewController: GeneralBottomSheetErrorViewDelegate {
func tryAgainBtnTapped(index: Int) {
    presenter?.callVerifyEmail(email: self.txtFieldEmail.text)
}
func closeBtnTapped() {
    
}
}
