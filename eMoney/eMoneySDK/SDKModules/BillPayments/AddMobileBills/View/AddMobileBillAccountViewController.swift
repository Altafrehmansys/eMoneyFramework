//
//  AddMobileBillAccountViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 22/05/2023.
//  
//

import Foundation
import UIKit

class AddMobileBillAccountViewController: BaseViewController {

    @IBOutlet weak var saveBillLabel: UILabel!
    @IBOutlet weak var btnContinue: BaseButton!
    @IBOutlet weak var btnTick: UIButton!
    @IBOutlet weak var nickNameTextField: StandardTextField!
    @IBOutlet weak var mobileTextField: StandardTextField!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: Properties
    var isSaveBill = true
    var presenter: AddMobileBillAccountPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    @IBAction func btnTickPressed(_ sender: Any) {
        
        self.btnTick.setImage(UIImage(named:"defaultCheckbox"), for: .normal)
        isSaveBill = !isSaveBill
        if isSaveBill {
            self.btnTick.setImage(UIImage(named:"redCheckbox"), for: .normal)
        }
    }
    
    
    @IBAction func btnContinuePressed(_ sender: Any) {
        self.presenter?.navigateToMobileBillEnterAmountScreen()
        
    }
}

extension AddMobileBillAccountViewController: AddMobileBillAccountViewProtocol {
    
    func setupUI() {
        setUpNavbar()
        titleLabel.text = "Etisalat"
        titleLabel.font = AppFont.appSemiBold(size: .body2)
        titleLabel.textColor = AppColor.eAnd_Black_80
        
        mobileTextField.entryType = .phoneNumber
        mobileTextField.prefix = "+971"
        mobileTextField.textFieldDidBeginEditingCallback = { [unowned self] in
            loadIdentitySheet()
        }
        mobileTextField.prefixColor = AppColor.eAnd_Black_80
        mobileTextField.prefixFont = AppFont.appSemiBold(size: .body2)
        mobileTextField.trailingButtonImage = "contact-icon"
        mobileTextField.placeholder = "Mobile number"
        mobileTextField.textFieldFont = AppFont.appRegular(size:.body2)
        mobileTextField.textFieldTextColor = AppColor.eAnd_Grey_70
        nickNameTextField.entryType = .text
        nickNameTextField.placeholder = "Name/Nickname (optional)"
        nickNameTextField.textFieldFont = AppFont.appRegular(size:.body2)
        nickNameTextField.textFieldTextColor = AppColor.eAnd_Grey_50
        
        saveBillLabel.text = "Save this for future bill payments"
        saveBillLabel.font = AppFont.appRegular(size: .body4)
        saveBillLabel.textColor = AppColor.eAnd_Black_80
        btnContinue.setTitle("Continue", for: .normal)
        
        
    }
    
    func loadIdentitySheet(){
        self.presenter?.showIdentityVerificationBottomSheet()
   }
    
    private func setUpNavbar(){
        self.navigationItem.setTitle(title: "Mobile postpaid & recharge",subtitle: "Account details")
        self.createNavBackBtn()
     
    }
   
}
