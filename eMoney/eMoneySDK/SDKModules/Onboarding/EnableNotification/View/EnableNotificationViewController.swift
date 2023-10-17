//
//  EnableNotificationViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/04/2023.
//  
//

import Foundation
import UIKit
import UserNotifications
import Lottie

class EnableNotificationViewController: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var imageViewNotification: UIImageView!
    
    @IBOutlet weak var labelHeadingNotification: UILabel!
    
    @IBOutlet weak var labelDescNotification: UILabel!
    
    @IBOutlet weak var buttonNotNow: UIButton!
    
    @IBOutlet weak var buttonEnablePushNotification: BaseButton!
    
    @IBOutlet weak var bellAnimatonView: LottieAnimationView!
    
    // MARK: Properties
    
    var presenter: EnableNotificationPresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewInterface()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
    }
    func setViewInterface(){
        
        self.labelHeadingNotification.text = "get_notifications".localized
        self.labelHeadingNotification.textColor = AppColor.eAnd_Black_80
        self.labelHeadingNotification.font = AppFont.appSemiBold(size: .h6)
        
        self.labelDescNotification.text = "get_notifications_desc".localized
        self.labelDescNotification.textColor = AppColor.eAnd_Grey_100
        self.labelDescNotification.font = AppFont.appRegular(size: .body3)
        
        self.buttonEnablePushNotification.setTitle("enable_push_notifications".localized, for: .normal)
        self.buttonEnablePushNotification.setTitleColor(AppColor.eAnd_White, for: .normal)
        self.buttonEnablePushNotification.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        
        buttonNotNow.setTitle("not_now".localized, for: .normal)
    }
    func setupAnimation(){
//        Waiting
//        Update-app
//
        bellAnimatonView.animation = LottieAnimation.named("Notification_bell_V3")
        bellAnimatonView.contentMode = .scaleAspectFill
        bellAnimatonView.loopMode = .repeat(3)
        bellAnimatonView.play()
    }
    
    @MainActor func showSimpleAlert(title:String,desc : String,actionOne:String,actionTwo:String) async {
        let alert = UIAlertController(title: title, message: desc,preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionOne, style: .default, handler: { _ in
           
        }))
        alert.addAction(UIAlertAction(title: actionTwo,
                                      style: .default,
                                      handler: {(_: UIAlertAction!) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .sound, .badge]) { [weak self] granted, _ in
                    print("Permission granted: \(granted)")
                    guard granted else {
                        Task {
                            await self?.showSimpleAlert(title: "noti_permision_title".localized, desc: "noti_settings".localized, actionOne: "cancel".localized, actionTwo: "settings".localized)
                        }
                       
                        return
                    }
                    self?.getNotificationSettings()
                    
                }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                self.presenter?.routeToSelectCard()
            }
        }
    }
    
    // MARK: IBOutlets
    
    @IBAction func buttonEnableTapped(_ sender: Any) {
        registerForPushNotifications()
    }
    
    @IBAction func buttonNotNowTapped(_ sender: Any) {
        presenter?.routeToSelectCard()
    }
    
    
}

extension EnableNotificationViewController: EnableNotificationViewProtocol {
    
}
