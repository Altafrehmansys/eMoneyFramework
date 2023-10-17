//
//  FailedOtpViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation
import UIKit

class FailedOtpViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var imageViewLock: UIImageView!
    @IBOutlet weak var labelFailOtp: UILabel!
    @IBOutlet weak var labelSec: UILabel!
    @IBOutlet weak var labelMin: UILabel!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    // MARK: Properties
    var timer : Timer?
    var counter = 0
    var presenter: FailedOtpPresenterProtocol?
    var responseObj: VerifyMobileNumberResponseModel?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setViewInterface()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        //convertMinutesIntoSeconds()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
//    func convertMinutesIntoSeconds() {
//        let time = (responseObj?.data?.remainingTimeInSeconds ?? 0)
//        counter = time
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
//    }
    
    // MARK: Set View Interface
    func setViewInterface(){
        labelFailOtp.text = "fail_otp".localized
        labelSec.text = "seconds".localized
        labelMin.text = "minutes".localized
        labelHours.text = "hours".localized
        labelDesc.text = "otp_try_again".localized
        labelFailOtp.font = AppFont.appSemiBold(size: .h7)
        labelFailOtp.textColor = AppColor.eAnd_Black_80
        labelDesc.font = AppFont.appRegular(size: .body3)
        labelDesc.textColor = AppColor.eAnd_Grey_100
        labelTimer.font = AppFont.appSemiBold(size: .h2)
        labelTimer.textColor = AppColor.eAnd_Black_80
        labelSec.font = AppFont.appRegular(size: .body3)
        labelSec.textColor = AppColor.eAnd_Grey_100
        labelMin.font = AppFont.appRegular(size: .body3)
        labelMin.textColor = AppColor.eAnd_Grey_100
        labelHours.font = AppFont.appRegular(size: .body3)
        labelHours.textColor = AppColor.eAnd_Grey_100
        self.isHideNavigation(false)
        self.createNavBackBtn()
        let time = (responseObj?.data?.remainingTimeInSeconds ?? 0)
        counter = time
    }
    
    // background timer
    // date save
    // wapis se difference n foreground
    //
    override func popViewController() {
        self.navigationController?.popViewControllers(viewsToPop: 2)
    }
    
    @objc func updateTimer() {
        if counter >= 0 {
            labelTimer.text = timeString(time: TimeInterval(counter))
        }
        else {
            timer?.invalidate()
            self.popViewController()
        }
       
    }
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        counter -= 1
        print(counter)
        return String(format:"%02i : %02i : %02i", hours, minutes, seconds)
    }
}

extension FailedOtpViewController: FailedOtpViewProtocol {
    
}
