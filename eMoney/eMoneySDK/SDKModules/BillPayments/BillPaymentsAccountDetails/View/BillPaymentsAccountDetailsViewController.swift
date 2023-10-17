//
//  BillPaymentsAccountDetailsViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 26/05/2023.
//  
//

import Foundation
import UIKit

class BillPaymentsAccountDetailsViewController: BaseViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var providerImage: UIImageView!
    @IBOutlet private weak var providerName: UILabel!
    @IBOutlet private weak var mobileTextField: StandardTextField!
    @IBOutlet private weak var fullNameTextField: StandardTextField!
    @IBOutlet private weak var addressTextField: StandardTextField!
    @IBOutlet private weak var nickNameTextField: StandardTextField!

    // MARK: Properties

    var presenter: BillPaymentsAccountDetailsPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
    }
    
    private func setUI() {
        setNavigationController()
        setMobileTextField()
        setAddressTextField()
        setFullnameTextField()
        setNicknameTextField()
    }
    private func setNavigationController() {
        self.navigationItem.setTitle(title: "International payments", subtitle: "Account details")
        createNavBackBtn()
    }
    private func setMobileTextField() {
        mobileTextField.placeholder = "000 0000 000"
        mobileTextField.prefix = "+971"
        mobileTextField.prefixColor = AppColor.eAnd_Black_80
        mobileTextField.entryType = .phoneNumber
        mobileTextField.trailingButtonImage = "contact-icon"
        mobileTextField.borderColor = AppColor.eAnd_Grey_20
        mobileTextField.setupConfigurations()

    }
    private func setAddressTextField() {
        addressTextField.entryType = .text
        addressTextField.placeholder = "Address"
        addressTextField.borderColor = AppColor.eAnd_Grey_20
    }
    private func setFullnameTextField() {
        fullNameTextField.entryType = .text
        fullNameTextField.placeholder = "Fullname"
        fullNameTextField.borderColor = AppColor.eAnd_Grey_20

    }
    private func setNicknameTextField() {
        nickNameTextField.entryType = .text
        nickNameTextField.placeholder = "Nickname"
        nickNameTextField.borderColor = AppColor.eAnd_Grey_20
    }
    
    @IBAction func continueBtnToCharge(_ sender: UIButton) {
        presenter?.didTapContinueBtn()
    }
}

extension BillPaymentsAccountDetailsViewController: BillPaymentsAccountDetailsViewProtocol {
    
}
