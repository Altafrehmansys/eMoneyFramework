//
//  BankAlertViewController.swift
//  etisalatWallet
//
//  Created by Muhammad Awais Anjum on 28/09/2022.
//  Copyright © 2022 Etisalat UAE. All rights reserved.
//

import UIKit

class BankAlertViewController: UIViewController {
    
    var presenter : BankAlertPresenter?

    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gotitBtn: BaseButton!
    
    public var dismissClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        //presenter?.dismiss()
        self.dismiss(animated: true) {
            self.dismissClosure?()
        }
    }
}

//MARK: - RELOAD
extension BankAlertViewController : BankAlertView {
    func setupUI() {
        seperatorView.layer.cornerRadius = 4.0
        seperatorView.layer.masksToBounds = true
        titleLabel.textColor = AppColor.eAnd_Black_80
        titleLabel.text = Strings.AddMoney.accountLinkingInitiated
        descriptionLabel.textColor = AppColor.eAnd_Grey_100
        descriptionLabel.text = Strings.AddMoney.itMayTakeUpTo24Hours
        gotitBtn.type = .GradientButton
        gotitBtn.setTitle(Strings.AddMoney.gotIt, for: .normal)
    }
}
