//
//  LeanCoolOffBottomSheetViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 31/07/2023.
//  
//

import Foundation
import UIKit

class LeanCoolOffBottomSheetViewController: BaseViewController {

    // MARK: - OUtlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstDescriptionLabel: UILabel!
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    @IBOutlet weak var coolDownTimeLabel: UILabel!
    @IBOutlet weak var coolDownTimeView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var understoodButton: BaseButton!
    
    // MARK: Properties
    var presenter: LeanCoolOffBottomSheetPresenterProtocol?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

// MARK: - class methods
extension LeanCoolOffBottomSheetViewController: LeanCoolOffBottomSheetViewProtocol {
    
    func setupUI() {
        self.titleLabel.text = Strings.AddMoney.almostDone
        self.titleLabel.font = AppFont.appSemiBold(size: .h7)
        self.titleLabel.textColor = AppColor.eAnd_Black_80
        
        self.coolDownTimeLabel.font = AppFont.appSemiBold(size: .h4)
        self.coolDownTimeLabel.textColor = AppColor.eAnd_Red_100
        
        self.firstDescriptionLabel.text = Strings.AddMoney.giveUsSomeTime
        self.firstDescriptionLabel.font = AppFont.appRegular(size: .body3)
        self.firstDescriptionLabel.textColor = AppColor.eAnd_Black_80
        
        self.secondDescriptionLabel.text = Strings.AddMoney.youWillBeNotified
        self.secondDescriptionLabel.font = AppFont.appRegular(size: .body3)
        self.secondDescriptionLabel.textColor = AppColor.eAnd_Black_80
        
        self.understoodButton.setTitle(Strings.AddMoney.gotIt, for: .normal)
        self.understoodButton.type = .GradientButton
        
        self.addSwipeDown(on: self.containerView)
    }
    
    func showCoolDownTimeForSeconds(seconds: Int) {
        var interval = seconds
        if interval > 0 {
            self.coolDownTimeLabel.text = self.secondsToTime(interval: interval)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                if interval < 0 {
                    timer.invalidate()
                    self.presenter?.dismiss()
                    return
                }
                self.coolDownTimeLabel.text = self.secondsToTime(interval: interval)
                interval = interval - 1
            })
        } else {
            self.coolDownTimeView.isHidden = true
        }
    }
    
    
    private func secondsToTime(interval:Int) -> String {
         let (h,m,s) = (interval / 3600, (interval % 3600) / 60, (interval % 3600) % 60)
         let h_string = h < 10 ? "0\(h)" : "\(h)"
         let m_string =  m < 10 ? "0\(m)" : "\(m)"
         let s_string =  s < 10 ? "0\(s)" : "\(s)"
         return "\(h_string) h : \(m_string) m : \(s_string) s"
     }
}

// MARK: - Actions
extension LeanCoolOffBottomSheetViewController {
    @IBAction func understoodButtonTapped(_ sender: UIButton) {
        self.presenter?.dismiss()
    }
}
