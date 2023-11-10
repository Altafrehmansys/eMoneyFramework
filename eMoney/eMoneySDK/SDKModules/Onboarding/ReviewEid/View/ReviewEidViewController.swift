//
//  ReviewEidViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 22/04/2023.
//  
//

import Foundation
import UIKit
import MDRSDK

class ReviewEidViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var stepsBar: BaseStepper!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var labelFront: UILabel!
    @IBOutlet weak var imgViewFront: UIImageView!
    @IBOutlet weak var labelBack: UILabel!
    @IBOutlet weak var imgViewBack: UIImageView!
    @IBOutlet weak var retakeBtn: BaseButton!
    @IBOutlet weak var verifyBtn: BaseButton!

    // MARK: Properties

    var presenter: ReviewEidPresenterProtocol?

    var sdkResponseData: MDROutput?
    
    var frontImage: UIImage?
    var backImage: UIImage?
    
    var updateType:UserUpdateType?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.loadData(updateType: self.updateType)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .onChangeTopCloseButton, object: nil, userInfo: ["isShow":true])
    }
    
    func setupUI() {
        self.navigationItem.setTitle(title: "register".localized, subtitle: "capture_identity".localized)
        self.stepsBar.addRedLine(noOfSteps: 4, currentStep: 1)
        self.createNavBackBtn()

        labelDesc.font = AppFont.appRegular(size: .body2)
        labelFront.font = AppFont.appRegular(size: .body2)
        labelBack.font = AppFont.appRegular(size: .body2)
        labelDesc.textColor = AppColor.eAnd_Black_80
        labelFront.textColor = AppColor.eAnd_Black_80
        labelBack.textColor = AppColor.eAnd_Black_80
        
        
        retakeBtn.setTitle("retake".localized, for: .normal)
        verifyBtn.setTitle("save_verify_identity".localized, for: .normal)
        
        labelDesc.text = "review_desc".localized
        labelFront.text = "front_side".localized
        labelBack.text = "back_side".localized
        
        self.imgViewFront.image = self.frontImage
        self.imgViewBack.image = self.backImage
        if SDKColors.shared.flowName == SDKFlowName.updateEmiratesId.rawValue {
            GlobalData.shared.backImage = self.backImage
            GlobalData.shared.frontImage = self.frontImage
        }
    }
    
    // MARK: Actions
    @IBAction func retakeTapped(_ sender: Any) {
        self.popViewController()
    }
    
//    @IBAction func retakeBackTapped(_ sender: Any) {
//        self.popViewController()
//    }
    
    @IBAction func verifyTapped(_ sender: Any) {
        presenter?.getOcrAnalyze(imageFront: self.sdkResponseData?.imageFront, imageBack: self.sdkResponseData?.imageBack)
    }
}

extension ReviewEidViewController: ReviewEidViewProtocol {

}
