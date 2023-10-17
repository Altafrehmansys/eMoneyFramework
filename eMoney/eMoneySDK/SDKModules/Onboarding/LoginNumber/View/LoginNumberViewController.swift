//
//  LoginNumberViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 10/05/2023.
//  
//

import Foundation
import UIKit

class LoginNumberViewController: BaseViewController {

    // MARK: Outlets
    @IBOutlet weak var viewField: StandardTextField!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imageViewTop: UIImageView!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var buttonLogin: BaseButton!
    
    // MARK: Properties

    var presenter: LoginNumberPresenterProtocol?
    var msisdn = String()

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingViewInterface()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isHideNavigation(true)
    }
    
    // MARK: SettingViewInterface
    func settingViewInterface(){
        settingTheColorAndFonts()
        self.buttonLogin.disable()
        viewField.placeholder = "000 0000 000"
        viewField.prefix = "+971"
        viewField.prefixColor = AppColor.eAnd_Black_80
        viewField.entryType = .phoneNumber
        viewField.state = .normal
        viewField.setupConfigurations()
        
        self.viewTop.addGradient(colors: [
            AppColor.backGroundHeaderGradiant1,
            AppColor.backGroundHeaderGradiant2
        ], locations: nil, startPoint: .unitCoordinate(.top), endPoint: .unitCoordinate(.bottom),cornerRadius: 0)
      
        setupTextFieldDelegates()
    }
    
    func settingTheColorAndFonts(){
        self.labelDesc.text = "login_to_your_e_money_account".localized
        self.labelDesc.textColor = AppColor.eAnd_Black_80
        self.labelDesc.font = AppFont.appRegular(size: .body2)
        self.buttonLogin.setTitle("login_btn_text".localized, for: .normal)
        viewField.prefixFont = AppFont.appSemiBold(size: .body2)
        viewField.textFieldFont = AppFont.appRegular(size: .body2)
        viewField.prefixColor = AppColor.eAnd_Black_80
        viewField.textFieldTextColor = AppColor.eAnd_Black_80
    }
    func buttonEnableDisableValidation(){
        if self.viewField.text.count  > 10 {
                self.buttonLogin.enable()
        }
        else {
            self.buttonLogin.disable()
        }
    }
    private func setupTextFieldDelegates() {
        viewField.textChangedCallback = {
            self.buttonEnableDisableValidation()
        }
    }
   
    @IBAction func buttonLoginTapped(_ sender: Any) {
        msisdn = CommonMethods.getFormattedMobileNumber(prefix:self.viewField.prefix ?? "" , number: self.viewField.text)
        presenter?.checkMobileNumberStatus(msisdn:msisdn)
    }
    func navigateToVerify(){
        presenter?.navigateToVerify(msisdn: msisdn)
    }
}

extension LoginNumberViewController: LoginNumberViewProtocol {
    func registerStatusRequestResponse(response: RegisterMobileNumberResponseModel) {
        SDKColors.shared.onSuccess?("\(#function) with response \(response)")
        navigateToVerify()
    }
    
    func registerStatusRequestResponseError(error: AppError) {
        SDKColors.shared.onFailure?("\(error.errorCode)", "\(error.localizedDescription)")
        print("error")
    }
}
