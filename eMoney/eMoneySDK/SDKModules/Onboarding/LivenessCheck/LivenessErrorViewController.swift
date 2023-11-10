//
//  LivenessErrorViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 26/04/2023.
//

import UIKit

protocol LivenessErrorViewControllerDelegate:AnyObject{
    func tryAgainBtnTapped()
    func closeBtnTapped()
}

class LivenessErrorViewController: BaseViewController {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var currentMoveLeftLabel: UILabel!
    @IBOutlet weak var btnTryAgain: BaseButton!
    
    weak var delegate:LivenessErrorViewControllerDelegate?
    
    var errorMsg:String = ""
    
    var isPlainError:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        
        self.detailLabel.text = "selfi_error_2".localized
        self.btnTryAgain.setTitle("try_again".localized, for: .normal)
        if isPlainError {
            self.titleLabel.text = "somrthing_went_wrong".localized
            self.detailLabel.text = errorMsg
            self.currentMoveLeftLabel.text = ""
        }else {
            self.titleLabel.text = "somrthing_went_wrong".localized

            let totalCount = 3
            let leftCount = GlobalData.shared.livenesRetriesLeft
            let formattedString = String(format: "selfi_attempt_msg".localized, leftCount, totalCount)
            self.currentMoveLeftLabel.text = formattedString
            
            if leftCount <= 0 {
                self.btnTryAgain.setTitle("ok".localized, for: .normal)
            }
            
            self.detailLabel.text = errorMsg
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    func setupUI(){
        self.titleLabel.font = AppFont.appSemiBold(size: .h7)
        self.detailLabel.font = AppFont.appRegular(size: .body3)
        self.currentMoveLeftLabel.font = AppFont.appMedium(size: .body1)
        
        self.titleLabel.textColor = AppColor.eAnd_Black_80
        self.detailLabel.textColor = AppColor.eAnd_Grey_100
        self.currentMoveLeftLabel.textColor = AppColor.eAnd_Black_80
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.closeBtnTapped()
        }
    }
    
    @IBAction func tryAgainTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.tryAgainBtnTapped()
        }
    }
}
