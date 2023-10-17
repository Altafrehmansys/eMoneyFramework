//
//  LoginViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation
import UIKit
import LocalAuthentication
//import IQKeyboardManagerSwift

public class LoginViewController: BaseViewController {
    
    // MARK: Outlets
    @IBOutlet weak var viewField: StandardTextField!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imageViewTop: UIImageView!
    
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonNotNow: UIButton!
    
    @IBOutlet weak var buttonLogin: BaseButton!
    
    @IBOutlet weak var imageViewHideShow: UIImageView!
    @IBOutlet weak var labelHideShow: UILabel!
    @IBOutlet weak var buttonHideShow: UIButton!
    @IBOutlet weak var faceIdLabel: UILabel!
    @IBOutlet weak var faceIdView: UIView!
    
    // MARK: Properties
    
    var presenter: LoginPresenterProtocol?
    var pin = String()
    var isPasswordHide = true
    
    // MARK: Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        CommonMethods.disableDarkMode()
        if UIApplication.isFirstLaunchAfterUpdate(){
            LocaleManager.shared.LoadLanguagePackFromLocalFile()
        }else{
            LocaleManager.shared.loadLanguagePack()
        }
        IQKeyboardManager.shared.enable = true
        
        
        settingViewInterface()
        setIsPasswordHide(passwordHide: isPasswordHide)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isHideNavigation(true)
    }
    
    // MARK: SettingViewInterface
    func settingViewInterface(){
        self.labelName.text = "hi".localized
        if let name = UserDefaultHelper.userName,name != "" {
            let firstName = name.components(separatedBy: " ").first ?? ""
            self.labelName.text = "hi".localized + " " + "\(firstName)!"
        }
        self.labelDesc.text = "enter_pin_to_login".localized
        self.labelHideShow.text = "show".localized
        self.faceIdLabel.text = "Use face/touch ID".localized
        self.buttonLogin.setTitle("login_btn_text".localized, for: .normal)
        self.buttonNotNow.setTitle("forgot_pin".localized, for: .normal)
        self.labelName.font = AppFont.appSemiBold(size: .h7)
        self.labelName.textColor = AppColor.eAnd_Black_80
        self.labelDesc.font = AppFont.appRegular(size: .body2)
        self.labelDesc.textColor = AppColor.eAnd_Black_80
        self.labelHideShow.font = AppFont.appMedium(size: .body4)
        self.labelHideShow.textColor = AppColor.eAnd_Red_100
        self.buttonNotNow.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        self.buttonNotNow.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        self.viewField.textFieldFont = AppFont.appRegular(size: .h7)
        self.viewField.textFieldTextColor = AppColor.eAnd_Black_80
        
        self.viewField.title = "enter_pin".localized
        self.viewField.state = .normal
        self.viewField.entryType = .numberPad
        self.viewField.state = .normal
        
        self.viewTop.addGradient(colors: [
            AppColor.backGroundHeaderGradiant1,
            AppColor.backGroundHeaderGradiant2
        ], locations: nil, startPoint: .unitCoordinate(.top), endPoint: .unitCoordinate(.bottom),cornerRadius: 0)
        
        configureOtpField()
        
        if (UserDefaultHelper.userBiomatricToken != nil) {
            self.faceIdView.isHidden = false
        }else{
            self.faceIdView.isHidden = true
        }
        
        //Enable custom keyboard
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self
        //keyboardView.target = viewField.getTextField
        //viewField.getTextField.inputView = keyboardView
    }
    
    func configureOtpField() {
        self.buttonLogin.disable()
        self.viewField.state = .normal
        self.viewField.entryType = .numberPad
        self.viewField.textLimit = 8
        setupTextFieldDelegates()
        
    }
    func validatePin(pinInput : String){
        if self.pin.count > 3 {
            self.buttonLogin.enable()
        }
        else {
            self.buttonLogin.disable()
        }
    }
    
    private func setupTextFieldDelegates() {
        viewField.textChangedCallback = {
            self.pin = self.viewField.text
            self.validatePin(pinInput: self.pin)
        }
    }
    func setIsPasswordHide(passwordHide : Bool){
        if passwordHide {
            labelHideShow.text = "show".localized
            labelHideShow.textColor = AppColor.eAnd_Error_100
            labelHideShow.font = AppFont.appRegular(size: .body4)
            imageViewHideShow.image = UIImage(named:"eye")
            self.viewField.isSecureTextEntry = true
        }
        else {
            labelHideShow.text = "hide".localized
            labelHideShow.textColor = AppColor.eAnd_Error_100
            labelHideShow.font = AppFont.appRegular(size: .body4)
            imageViewHideShow.image = UIImage(named:"eye-slash")
            self.viewField.isSecureTextEntry = false
        }
    }
    
    // MARK: IB Actions
    
    @IBAction func buttonHideShowTapped(_ sender: Any) {
        isPasswordHide = !isPasswordHide
       setIsPasswordHide(passwordHide: isPasswordHide)
    }
    @IBAction func buttonNotNowTapped(_ sender: Any) {
        presenter?.naviateToForgotPassword()
    }
    
    @IBAction func faceIdTapped(_ sender: Any) {
        enableFaceTouchId()
    }
    
    @IBAction func buttonLoginTapped(_ sender: Any) {
        
        presenter?.loginApiCall(pin: self.pin)
    }
}

extension LoginViewController: LoginViewProtocol {
    func loginResponse(response: LoginResponseModel) {
        print(response)
    }
    func loginResponseError(error: AppError) {
        print(error)
    }
}

extension LoginViewController{
    // MARK: Enable Face Touch Id
    
    func enableFaceTouchId() {
        let context = LAContext()
        var error: NSError?
      
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "enable_face".localized
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if success {
                        self.presenter?.loginApiCall(pin: UserDefaultHelper.userBiomatricToken!)
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
}

extension LoginViewController : KeyboardDelegate {
    func keyCrossTapped() {
    }
    func currentValuestring(value: String) {
        
    }
    
    func keyScanTapped() {
        enableFaceTouchId()
    }
    
    func keyWasTapped(character: String) {

    }
}
