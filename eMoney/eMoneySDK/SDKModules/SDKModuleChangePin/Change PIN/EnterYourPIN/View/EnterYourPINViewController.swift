//
//  EnterYourPINViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation
import UIKit

class EnterYourPINViewController: BaseViewController {
    @IBOutlet weak var enterYourPINLabel: UILabel!
    @IBOutlet weak var cardPINTextField: StandardTextField!
    @IBOutlet weak var btnNext: BaseButton!
    // MARK: Properties

    @IBOutlet weak var btnShowHide: UIButton!
    @IBOutlet weak var nextButtonBottomMargin: NSLayoutConstraint!
    var presenter: EnterYourPINPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        self.isHideNavigation(false)
        setUpNavBar()
    }
    
    private func setUpNavBar(){
        self.navigationItem.setTitle(title:"change_pin".localized, subtitle:"current_pin".localized)
        self.createNavBackBtn()
    }
    private func setUpScreenUI(){
        enterYourPINLabel.text = "current_pin_first".localized
        enterYourPINLabel.font = AppFont.appRegular(size: .body2)
        enterYourPINLabel.textColor = AppColor.eAnd_Black_80
        
        btnShowHide.setTitle("show".localized, for: .normal)
        btnShowHide.setImage(UIImage(named: "eye"), for: .normal)
        btnShowHide.setImage(UIImage(named: "eye-slash"), for: .selected)
        btnShowHide.isSelected = false
        btnShowHide.tintColor = AppColor.eAnd_Red_100
    }
    
    @IBAction func btnShowHidePressed(_ sender: Any) {
        btnShowHide.isSelected.toggle()
        if btnShowHide.isSelected{
            cardPINTextField.entryType = .password
        }else{
            cardPINTextField.entryType = .text
        }
       
    }
    @IBAction func btnForgotPINPressed(_ sender: Any) {
        self.presenter?.navigateToForgotPINScreen()
        
    }
    @IBAction func btnNextPressed(_ sender: Any) {
    }
    
}

extension EnterYourPINViewController: EnterYourPINViewProtocol {
    
}
