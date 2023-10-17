//
//  AccountDetailsViewController.swift
//  e&money
//
//  Created by Usama Zahid Khan on 24/05/2023.
//  
//

import Foundation
import UIKit

class AccountDetailsViewController: BaseViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAccountType: UILabel!
    @IBOutlet weak var btnPostpaid: UIButton!
    @IBOutlet weak var btnPrepaid: UIButton!
    @IBOutlet weak var btnSaveCheckbox: UIButton!
    @IBOutlet weak var btnContinue: BaseButton!
    @IBOutlet weak var tfNumber:StandardTextField!
    @IBOutlet weak var tfName:StandardTextField!
    
    // MARK: Properties

    var presenter: AccountDetailsPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    @IBAction func didTapAccountType(_ sender:UIButton) {
        if sender.tag == 0 {
            self.btnPrepaid.isSelected = true
            self.btnPostpaid.isSelected = false
        }else{
            self.btnPrepaid.isSelected = false
            self.btnPostpaid.isSelected = true
        }
    }
    @IBAction func didTapSaveForFuture(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func didTapContinue(_ sender:Any) {
        presenter?.navigateToSelectPlan()
    }
}

extension AccountDetailsViewController: AccountDetailsViewProtocol {
    func setupUI() {
        self.lblTitle.font = AppFont.appSemiBold(size: .body2)
        self.lblAccountType.text = "Account Type"
        self.lblAccountType.font = AppFont.appSemiBold(size: .body2)
        self.btnPrepaid.setTitle("Prepaid".localized, for: .normal)
        self.btnPrepaid.titleLabel?.font = AppFont.appRegular(size: .body4)
        self.btnPostpaid.titleLabel?.font = AppFont.appRegular(size: .body4)
        self.btnPostpaid.setTitle("Postpaid".localized, for: .normal)
        self.btnContinue.setTitle("Continue".localized, for: .normal)
        self.btnContinue.type = .GradientCircleButton
        self.view.backgroundColor = .white
        self.tfName.textFieldFont = AppFont.appRegular(size: .body2)
        self.tfNumber.textFieldFont = AppFont.appRegular(size: .body2)
        self.tfNumber.entryType = .numberPad
        self.tfNumber.trailingButtonImage = "personalcardEmpty"
        self.tfNumber.state = .normal
        
        self.tfNumber.entryType = .phoneNumber
        self.tfNumber.placeholder = "00 000 0000"
        self.tfNumber.prefix = "+971"
        self.tfNumber.prefixColor = AppColor.eAnd_Black_80
        self.tfNumber.state = .normal
        self.tfNumber.setupConfigurations()
        
        self.setupNavigatioBar()
        
    }
    private func setupNavigatioBar() {
        self.createNavBackBtn()
        self.navigationItem.setTitle(title: "Account details".localized,subtitle: "Mobile Postpaid & Recharge".localized)
    }
}
