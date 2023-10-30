//
//  ForgotPasswordViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 15/06/2023.
//  
//

import Foundation
import UIKit

class ForgotPasswordViewController: BaseViewController {

    // MARK: Outlets
    @IBOutlet weak var imageViewTick: UIImageView!
    @IBOutlet weak var labelPin: UILabel!
    @IBOutlet weak var labelPinDesc: UILabel!
    @IBOutlet weak var buttonDone: BaseButton!
    @IBOutlet weak var downloadButton: BaseButton!
    @IBOutlet weak var mainView: UIView!
    
    
    // MARK: Properties

    var presenter: ForgotPasswordPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        presenter?.loadData()
        NotificationCenter.default.post(name: .onChangeScreenSize, object: nil, userInfo: ["size":"half"])
    }
    @IBAction func buttonDoneTapped(_ sender: Any) {
        presenter?.backToLogin()
    }
    
    @IBAction func buttonDownloadTapped(_ sender: Any) {
        //presenter?.backToLogin()
    }
    
    private func setUI() {
        labelPin.font = AppFont.appSemiBold(size: .h7)
        labelPin.text = "emoney_account_created_success".localized
        labelPinDesc.font = AppFont.appRegular(size: .body3)
        labelPinDesc.text = "emoney_account_created_success_desc".localized
        labelPinDesc.textColor = AppColor.eAnd_Gray
        buttonDone.setTitle("continue_btn_text".localized, for: .normal)
        downloadButton.setTitle("downloadeMoney".localized, for: .normal)
        mainView.layer.cornerRadius = 20
        mainView.layer.masksToBounds = true
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewProtocol {
    
}
