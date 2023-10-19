//
//  RegisterMobileNumberViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation
import UIKit
//import IQKeyboardManagerSwift

public class RegisterMobileNumberViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewField: StandardTextField!
    //    @IBOutlet weak var viewTop: UIView!
    //    @IBOutlet weak var imageViewTop: UIImageView!
    
    @IBOutlet weak var buttonJoinEmoney: BaseButton!
    @IBOutlet weak var stackViewText: UIStackView!
    @IBOutlet weak var stackViewImage: UIStackView!
    @IBOutlet weak var labelTermsAndCond: UILabel!
    @IBOutlet weak var labelTop: UILabel!
    
    @IBOutlet weak var constraintBottomButton: NSLayoutConstraint!
    @IBOutlet weak var imageViewPrivacy: UIImageView!
    @IBOutlet weak var imageViewTerms: UIImageView!
    @IBOutlet weak var labelPrivacyPolicy: UILabel!
    //    @IBOutlet weak var buttonJoinEmoneyTapped: BaseButton!
    // MARK: Properties
    var presenter: RegisterMobileNumberPresenterProtocol?
    var msisdn = String()
    var isSelectPrivacy = false
    var isSelectTerms = false
    var delegate: SendDataSDK?
    
//    var onSuccess: ((String) -> ())?
//    var onFailure: ((String) -> ())?
    // MARK: Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        UIFont.registerFontsIfNeeded()
        if UIApplication.isFirstLaunchAfterUpdate(){
            print("LoadLanguagePackFromLocalFile")
            LocaleManager.shared.LoadLanguagePackFromLocalFile()
        } else {
            print("loadLanguagePack")
            LocaleManager.shared.loadLanguagePack()
        }
        if "sign_up_future".localized == "sign_up_future"  {
            print("language pack not loaded")
//            self.getLangPack(selectedLang: LocaleManager.currentLanguage())
        } else {
            print("language pack loaded")
        }
        IQKeyboardManager.shared.enable = true
        
        if self.presenter == nil {
            _ = RegisterMobileNumberRouter.setupModule(vc: self)
        } else {
            print("presenter was not nil")
        }
        
        settingViewInterface()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
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
                    //                    CommonMethods.setRootViewController(viewController: WalkthroughIntroRouter.setupModule())
//                    DispatchQueue.main.async {
                        self.settingViewInterface()
//                    }
                }else{
                    Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: Strings.Generic.generalErrorMsg)
                }
            }
            
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isHideNavigation(true)
        
        self.delegate?.sendStringData(string: "Register")
        GlobalData.shared.msisdn = nil
    }
    
    // MARK: SettingViewInterface
    func settingViewInterface(){
        settingTheColorAndFonts()
        setAttributeTextForPrivacyPolicy()
        setAttributeTextForTermsCondition()
        self.buttonJoinEmoney.disable()
        viewField.entryType = .phoneNumber
        viewField.placeholder = "00 000 0000"
        viewField.prefix = "+971"
        viewField.prefixColor = AppColor.eAnd_Black_80
        viewField.state = .normal
        viewField.setupConfigurations()
        viewField.text = SDKColors.shared.msisdn?.formattedPhoneNumber ?? ""
        if !viewField.text.isEmpty {
            viewField.state = .disabled
        }
        //        self.viewTop.addGradient(colors: [
        //            AppColor.backGroundHeaderGradiant1,
        //            AppColor.backGroundHeaderGradiant2
        //        ], locations: nil, startPoint: .unitCoordinate(.top), endPoint: .unitCoordinate(.bottom),cornerRadius: 0)
        self.imageViewPrivacy.image = UIImage(named:"defaultCheckbox")
        self.imageViewTerms.image = UIImage(named:"defaultCheckbox")
        
        setupTextFieldDelegates()
        self.updateBottomBtnConstraintOnKeyboardAppearing(self.constraintBottomButton, bottomPadding: 32)
    }
    
    func settingTheColorAndFonts(){
        self.labelTop.font = AppFont.appRegular(size: .body2)
        self.labelTop.textColor = AppColor.eAnd_Black_80
        self.labelTop.text = "sign_up_future".localized
        buttonJoinEmoney.setTitle("join_emoney".localized, for: .normal)
        viewField.prefixFont = AppFont.appSemiBold(size: .body2)
        viewField.textFieldFont = AppFont.appRegular(size: .body2)
        viewField.prefixColor = AppColor.eAnd_Black_80
        viewField.textFieldTextColor = AppColor.eAnd_Black_80
        labelTermsAndCond.font = AppFont.appRegular(size: .body4)
        labelTermsAndCond.textColor = AppColor.eAnd_Black_80
        labelPrivacyPolicy.textColor = AppColor.eAnd_Black_80
        labelPrivacyPolicy.font = AppFont.appRegular(size: .body4)
        buttonJoinEmoney.titleLabel?.font = AppFont.appSemiBold(size: .body2)
    }
    func buttonEnableDisableValidation(){
        if self.viewField.text.count  > 8 {
            if !CommonMethods.validateUAEMobileNumberWithOutCode(phoneNumber: self.viewField.text) {
                viewField.showError(with: "error_phone_add_account".localized)
                return
            }
            if self.isSelectTerms && self.isSelectPrivacy {
                self.buttonJoinEmoney.enable()
            }
            else {
                self.buttonJoinEmoney.disable()
            }
        }
        else {
            viewField.hideError()
            self.buttonJoinEmoney.disable()
        }
    }
    private func setupTextFieldDelegates() {
        viewField.textChangedCallback = {
            self.buttonEnableDisableValidation()
        }
    }
    
    func setAttributeTextForTermsCondition(){
        
        //        let mainString = "I accept the Terms and Conditions"
        //        let range = (mainString as NSString).range(of: "Terms and Conditions")
        //        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        //        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColor.eAnd_Black_80, range: NSRange(location: 0, length: mainString.count))
        //        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: AppFont.appRegular(size: .body4), range: NSRange(location: 0, length: mainString.count))
        //
        //        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColor.eAnd_Error_100, range: range)
        //        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: AppFont.appMedium(size: .body4), range: range)
        // mutableAttributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range:range)
        
        
        print(#function)
        var mutableAttrString = NSMutableAttributedString(string: "i_accept_the".localized, attributes: [ NSAttributedString.Key.foregroundColor: AppColor.eAnd_Black_80,NSAttributedString.Key.font:AppFont.appRegular(size: .body4)])
        mutableAttrString.append(NSAttributedString(string: " "))
        var mutableAttrString1 = NSMutableAttributedString(string: "terms_and_conditions_capital".localized, attributes: [ NSAttributedString.Key.foregroundColor: AppColor.eAnd_Error_100,NSAttributedString.Key.font:AppFont.appMedium(size: .body4)])
        mutableAttrString.append(mutableAttrString1)
        
        labelTermsAndCond.attributedText = mutableAttrString
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lblTermsTapped))
        labelTermsAndCond.addGestureRecognizer(tapGesture)
        labelTermsAndCond.isUserInteractionEnabled = true
    }
    @objc func lblTermsTapped(_ gesture: UITapGestureRecognizer) {
        let position = gesture.location(in: labelTermsAndCond)
        if position.x > 64 {
            presenter?.navigateToTermsCondition(privacyType: PrivacypolicyType.termsCondition)
        }
    }
    func setAttributeTextForPrivacyPolicy(){
        //        let mainString = "I accept the Privacy Policy"
        //        let range = (mainString as NSString).range(of: "Privacy Policy")
        //        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        //        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColor.eAnd_Black_80, range: NSRange(location: 0, length: mainString.count))
        //        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: AppFont.appRegular(size: .body4), range: NSRange(location: 0, length: mainString.count))
        //
        //        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColor.eAnd_Error_100, range: range)
        //        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: AppFont.appMedium(size: .body4), range: range)
        print(#function)
        var mutableAttrString = NSMutableAttributedString(string: "i_accept_the".localized, attributes: [ NSAttributedString.Key.foregroundColor: AppColor.eAnd_Black_80,NSAttributedString.Key.font:AppFont.appRegular(size: .body4)])
        mutableAttrString.append(NSAttributedString(string: " "))
        var mutableAttrString1 = NSMutableAttributedString(string: "privacy_policy".localized, attributes: [ NSAttributedString.Key.foregroundColor: AppColor.eAnd_Error_100,NSAttributedString.Key.font:AppFont.appMedium(size: .body4)])
        mutableAttrString.append(mutableAttrString1)
        labelPrivacyPolicy.attributedText = mutableAttrString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lblPrivacyTapped))
        labelPrivacyPolicy.addGestureRecognizer(tapGesture)
        labelPrivacyPolicy.isUserInteractionEnabled = true
    }
    
    @objc func lblPrivacyTapped(_ gesture: UITapGestureRecognizer) {
        let position = gesture.location(in: labelPrivacyPolicy)
        print(position)
        if position.x > 64 {
            presenter?.navigateToTermsCondition(privacyType: PrivacypolicyType.privacyPolicy)
        }
        
    }
    
    
    // MARK: IB Actions
    
    @IBAction func buttonTermsTapped(_ sender: Any) {
        self.imageViewTerms.image = UIImage(named:"defaultCheckbox")
        isSelectTerms = !isSelectTerms
        if isSelectTerms {
            self.imageViewTerms.image = UIImage(named:"redCheckbox")
        }
        self.buttonEnableDisableValidation()
        self.viewField.resignFirstResponder()
    }
    
    @IBAction func buttonPrivacyPolicyTapped(_ sender: Any) {
        self.imageViewPrivacy.image = UIImage(named:"defaultCheckbox")
        isSelectPrivacy = !isSelectPrivacy
        if isSelectPrivacy {
            self.imageViewPrivacy.image = UIImage(named:"redCheckbox")
        }
        self.buttonEnableDisableValidation()
        self.viewField.resignFirstResponder()
        
    }
    
    @IBAction func buttonJoinTapped(_ sender: Any) {
        view.endEditing(true)
        msisdn = CommonMethods.getFormattedMobileNumber(prefix:self.viewField.prefix ?? "" , number: self.viewField.text)
        
        print(#function)
        print(msisdn)
        
        
        presenter?.checkMobileNumberStatus(msisdn:msisdn)
        
    }
    func navigateToVerify(){
        
        presenter?.navigateToVerify(msisdn: msisdn, ref: self)
    }
    
    
    
}

// MARK: Viper View Delegates
extension RegisterMobileNumberViewController: RegisterMobileNumberViewProtocol {
    func registerStatusRequestResponse(response: RegisterMobileNumberResponseModel) {
        SDKColors.shared.onSuccess?("\(#function) with response \(response)")
        navigateToVerify()
    }
    
    func registerStatusRequestResponseError(error: AppError) {
        SDKColors.shared.onFailure?("\(error.errorCode)", "\(error.localizedDescription)")
        print("error")
    }
}
