//
//  SplashViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 01/05/2023.
//  
//

import UIKit
//import IQKeyboardManagerSwift

public class SplashViewController: BaseViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var viewAnimation: UIView!
    @IBOutlet weak var swipeUplabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // MARK: Properties
    var presenter: SplashPresenterProtocol?
    var animationDispatchGroup = DispatchGroup()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIApplication.isFirstLaunchAfterUpdate(){
            LocaleManager.shared.LoadLanguagePackFromLocalFile()
        } else {
            LocaleManager.shared.loadLanguagePack()
        }
        IQKeyboardManager.shared.enable = true

        
        
        if self.presenter == nil {
            _ = SplashRouter.setupModule(vc:self)
        }

        setInterface()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            let vc = AddRecipentRouter.setupModule()
//            CommonMethods.setRootViewController(viewController: vc)
//         }
        
        
//
        
        
    }
    public override func didInternetErrorTryAgainTapped() {
        print("TRAY AGAIN TAPPED")
        animationDispatchGroup = DispatchGroup()
        setInterface()
    }
    
    func animationSplash(){
        animationDispatchGroup.enter()
        let anim = SplashAnimation(OnView: self.viewAnimation)
        anim.play {
            self.animationDispatchGroup.leave()
        }
    }
    
    func setInterface(){
        animationSplash()
        
        self.setupView()
        print(LocaleManager.currentLanguage())
        
        if UIDevice().isJailBroken {
            print("phone is jail broken or run in simulator")
        }else{
            animationDispatchGroup.enter()
            self.presenter?.loadData()
        }
        
        
        animationDispatchGroup.notify(queue: DispatchQueue.main) {
            self.presenter?.checkStatus()
        }
    }
    func setupView(){
        swipeUplabel.textColor = AppColor.eAnd_Grey_100
        swipeUplabel.font = AppFont.appRegular(size: .body3)
        welcomeLabel.font = AppFont.appMedium(size: .h6)
        welcomeLabel.text = "welcome_to".localized
        swipeUplabel.text = "Swipe_up_lang".localized
        swipeUplabel.isHidden = true
        
        if UserDefaultHelper.isLangSelected {
            welcomeLabel.isHidden = true
        }
//        if let msisdn = UserDefaultHelper.msisdn,msisdn != ""{
//            welcomeLabel.isHidden = true
//        }
        
    }
    
    func addSwipeUpGesture(){
        swipeUplabel.isHidden = false
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        
        if gesture.direction == .up {
            print("Swipe Up")
            presenter?.navigateToSelectLanguage()
        }
    }
    
}


extension SplashViewController: SplashViewProtocol {
    func showLanguageSelection() {
        addSwipeUpGesture()
    }
    
    func onCheckAppVersionResponse(data:CheckAppVersionData) {
        
        if LocaleManager.shared.isLanguageUpdateRequired(serverVersion: data.languageVersion ?? ""){
            Task {
                let isSuccess = await LocaleManager.shared.getLanguagePackFromServer()
                DispatchQueue.main.async {
                }
            }
        }
        animationDispatchGroup.leave()
    }
    
    
}
