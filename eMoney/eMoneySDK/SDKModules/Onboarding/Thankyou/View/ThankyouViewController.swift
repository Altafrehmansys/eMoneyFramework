//
//  ThankyouViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 03/05/2023.
//  
//

import Foundation
import UIKit
import Lottie

class ThankyouViewController: BaseViewController {
    
    enum ScreenType {
        case amlVerification
        case amlUnverifiedSupport
        case softUpdate
        case hardUpdate
        case accountAlreadyRegister
        case accountUnderAge
        case fastTrack
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var imageViewDots: UIImageView!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var buttonNotNow: BaseButton!
    @IBOutlet weak var buttonContinue: BaseButton!
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelThankyou: UILabel!
    @IBOutlet weak var animatonView: LottieAnimationView!
    
    // MARK: Properties

    var presenter: ThankyouPresenterProtocol?
    var screenTypeEnum = ScreenType.amlVerification

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
       setViewInterface()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
    }
    
    func setupAnimation(name:String){
//        Waiting
//        Update-app
//
        animatonView.animation = LottieAnimation.named(name)
        animatonView.contentMode = .scaleAspectFill
        animatonView.loopMode = .repeat(3)
        animatonView.play()
    }
    
    // MARK: Setting the View Data
    func setViewInterface(){
        switch screenTypeEnum {
        case .hardUpdate:
            setupgradeForceData()
        case .softUpdate:
            setupgradeData()
        case .amlVerification:
           setAmlVerificationData()
        case .fastTrack:
           setFastTrackData()
        case .accountAlreadyRegister:
           setAlreadyRegisterData()
        case .accountUnderAge:
           setAccountUnderAgeData()
        case .amlUnverifiedSupport:
           setAmlUnverifiedSupportData()
        default :
            setupgradeForceData()
        }
    }
    override func popViewController() {
        if screenTypeEnum == .fastTrack {
            self.navigationController?.popViewControllers(viewsToPop: 2)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setAmlVerificationData(){
        labelThankyou.text = "thank_you_for_registering".localized
        labelThankyou.font = AppFont.appSemiBold(size: .h7)
        labelThankyou.textColor = AppColor.eAnd_Black_80
        labelDescription.text = "registration_under_review".localized
        labelDescription.font = AppFont.appRegular(size: .body3)
        labelDescription.textColor = AppColor.eAnd_Grey_100
        buttonContinue.setTitle("continue_as_guest_btn_text".localized, for: .normal)
        self.buttonNotNow.isHidden = true
        setupAnimation(name: "Waiting")
    }
    func setAmlUnverifiedSupportData(){
        labelThankyou.text = "aml_unverified_title".localized
        labelThankyou.font = AppFont.appSemiBold(size: .h7)
        labelThankyou.textColor = AppColor.eAnd_Black_80
        labelDescription.text = "aml_unverified_desc".localized
        labelDescription.font = AppFont.appRegular(size: .body3)
        labelDescription.textColor = AppColor.eAnd_Grey_100
        buttonContinue.setTitle("aml_unverified_btn_title".localized, for: .normal)
        self.buttonNotNow.isHidden = true
        setupAnimation(name: "no_account_v3")
    }
    func setFastTrackData(){
        labelThankyou.text = "fasttrack_registeration".localized
        labelThankyou.font = AppFont.appSemiBold(size: .h7)
        labelThankyou.textColor = AppColor.eAnd_Black_80
        labelDescription.text = "fasttrack_description".localized
        labelDescription.font = AppFont.appRegular(size: .body3)
        labelDescription.textColor = AppColor.eAnd_Grey_100
        buttonContinue.setTitle("agree_btntext".localized, for: .normal)
        self.buttonNotNow.isHidden = false
        buttonNotNow.setTitle("not_now".localized, for: .normal)
        buttonNotNow.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        buttonNotNow.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        //self.imageViewDots.image = UIImage(named:"timer")
        setupAnimation(name: "Timer")
        self.isHideNavigation(false)
        self.createNavBackBtn()
    }
    func setupgradeData(){
        labelThankyou.text = "update_time".localized
        labelThankyou.font = AppFont.appSemiBold(size: .h7)
        labelThankyou.textColor = AppColor.eAnd_Black_80
        labelDescription.text = "update_available".localized
        labelDescription.font = AppFont.appRegular(size: .body3)
        labelDescription.textColor = AppColor.eAnd_Grey_100
        buttonContinue.setTitle("update_btn".localized, for: .normal)
        self.buttonNotNow.isHidden = false
        buttonNotNow.setTitle("not_now".localized, for: .normal)
        buttonNotNow.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        buttonNotNow.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        //self.imageViewDots.image = UIImage(named:"upgrade")
        setupAnimation(name: "Update-app")
    }
    func setupgradeForceData(){
        labelThankyou.text = "update_time".localized
        labelThankyou.font = AppFont.appSemiBold(size: .h7)
        labelThankyou.textColor = AppColor.eAnd_Black_80
        labelDescription.text = "update_available".localized
        labelDescription.font = AppFont.appRegular(size: .body3)
        labelDescription.textColor = AppColor.eAnd_Grey_100
        buttonContinue.setTitle("update_btn".localized, for: .normal)
        self.buttonNotNow.isHidden = true
        //self.imageViewDots.image = UIImage(named:"upgrade")
        setupAnimation(name: "Update-app")
    }
    func setAlreadyRegisterData(){
        labelThankyou.text = "account_alreadyregistered".localized
        labelThankyou.font = AppFont.appSemiBold(size: .h7)
        labelThankyou.textColor = AppColor.eAnd_Black_80
        labelDescription.text = "emiratesId_alreadyregistered".localized
        labelDescription.font = AppFont.appRegular(size: .body3)
        labelDescription.textColor = AppColor.eAnd_Grey_100
        buttonContinue.setTitle("scan_anotherid".localized, for: .normal)
        self.buttonNotNow.isHidden = true
        self.imageViewDots.image = UIImage(named:"profilePic")
    }
    func setAccountUnderAgeData(){
        labelThankyou.text = "account_cantregistered".localized
        labelThankyou.font = AppFont.appSemiBold(size: .h7)
        labelThankyou.textColor = AppColor.eAnd_Black_80
        labelDescription.text = "account_underage".localized
        labelDescription.font = AppFont.appRegular(size: .body3)
        labelDescription.textColor = AppColor.eAnd_Grey_100
        buttonContinue.setTitle("scan_anotherid".localized, for: .normal)
        self.buttonNotNow.isHidden = true
        self.imageViewDots.image = UIImage(named:"sixteenYears")
    }
    // MARK: IBActions
    
    @IBAction func buttonNotNowTapped(_ sender: Any) {
        switch screenTypeEnum {
        case .hardUpdate:
            break
        case .softUpdate:
            break
        case .amlVerification:
           break
        case .fastTrack:
            GlobalData.shared.registrationType = .noKyc
            presenter?.navigateToEnterEmail()
           break
        case .accountAlreadyRegister:
            break
        case .accountUnderAge:
            break
        default :
            break
        }
    }
    
    @IBAction func proceedBtnTapped(_ sender: Any) {
        switch screenTypeEnum {
        case .hardUpdate:
            break
        case .softUpdate:
            break
        case .amlVerification:
            presenter?.navigateToHome()
           break
        case .fastTrack:
            GlobalData.shared.registrationType = .physicalKyc
            presenter?.navigateToEnterEmail()
           break
        case .accountAlreadyRegister:
            break
        case .accountUnderAge:
            break
        case .amlUnverifiedSupport:
            CommonMethods.callCustomerSpport()
            break
        default :
            break
        }
    }
    
}

extension ThankyouViewController: ThankyouViewProtocol {
    
}
