//
//  SendMoneyEnterAmountViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/05/2023.
//  
//

import Foundation
import UIKit

class SendMoneyEnterAmountViewController: BaseViewController {
    
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIBANNumberLabel: UILabel!
    @IBOutlet weak var amontTextField: BaseAmountField!
    @IBOutlet weak var descriptionTextField: UITextField!
    // MARK: Properties
    var presenter: SendMoneyEnterAmountPresenterProtocol?
    private var keyboardHelper: KeyboardHelper?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpNavBar()
        setUpUI()
      //  amontTextField.settingView(desc: "")
        
    }
    @IBAction func btnNextPressed(_ sender: Any) {
        self.presenter?.navigateToSendMoneyPaymentDetails()
    }
    private func setUpNavBar(){
        self.navigationItem.setTitle(title: "Send money",subtitle: "Account balance AED 349.50")
        self.createNavBackBtn()
    }
    private func setUpUI(){
        userNameLabel.font = AppFont.appRegular(size: .body3)
        userNameLabel.textColor = AppColor.eAnd_Black_80
        userIBANNumberLabel.font = AppFont.appRegular(size: .body4)
        userIBANNumberLabel.textColor = AppColor.eAnd_Grey_100
        amontTextField.settingView(desc: "")
        amontTextField.currentColor = AppColor.eAnd_Black_80
        
        keyboardHelper = KeyboardHelper { [unowned self] animation, keyboardFrame, duration in
            switch animation {
            case .keyboardWillShow:
                nextButtonBottomConstraint.constant = keyboardFrame.height
            case .keyboardWillHide:
                nextButtonBottomConstraint.constant = 24
            }
        }
    }
}

extension SendMoneyEnterAmountViewController: SendMoneyEnterAmountViewProtocol {
    
}
