//
//  DeliveryDetailsAddAdressViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import UIKit

class DeliveryDetailsAddAdressViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addressTypeTextField: StandardTextField!
    @IBOutlet private weak var addressLineTextField: StandardTextField!
    @IBOutlet private weak var cityTextField: StandardTextField!
    @IBOutlet private weak var emirateTextField: StandardTextField!
    @IBOutlet private weak var saveAddressLabel: UILabel!
    @IBOutlet private weak var saveSwitch: UISwitch!
    @IBOutlet private weak var confirmBtn: BaseButton!
    // MARK: Properties

    var presenter: DeliveryDetailsAddAdressPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
    }
    
    private func setUI() {
        setFonts()
        setLocalization()
        setConfirmBtn()
        setNavigationController()
        setAddressTypeTextField()
        setEmirateTypeTextField()
    }
    private func setNavigationController() {
        self.navigationItem.setTitle(title: Strings.Wallet.delivery_details_title, subtitle: "")
        createNavBackBtn()
    }
    private func setFonts() {
        titleLabel.font = AppFont.appRegular(size: .body3)
        cityTextField.textFieldFont = AppFont.appRegular(size: .body2)
        emirateTextField.textFieldFont = AppFont.appRegular(size: .body2)
        addressLineTextField.textFieldFont = AppFont.appRegular(size: .body2)
        addressTypeTextField.textFieldFont = AppFont.appRegular(size: .body2)
        saveAddressLabel.font = AppFont.appRegular(size: .body4)
    }
    
    private func setLocalization() {
        titleLabel.text = Strings.Wallet.delivery_address_get_Your_physical
        addressLineTextField.title = Strings.Wallet.address_line
        addressTypeTextField.title = Strings.Wallet.address_type
        cityTextField.title = Strings.Wallet.city
        emirateTextField.title = Strings.Wallet.emirate
        saveAddressLabel.text = Strings.Wallet.saveAddress
        confirmBtn.setTitle(Strings.Wallet.confirm_delivery_details, for: .normal)
        
    }
    
    private func setAddressTypeTextField() {
        addressTypeTextField.trailingButtonImage = "arrow-down"
    }
    private func setEmirateTypeTextField() {
        emirateTextField.trailingButtonImage = "arrow-down"
    }
    private func setConfirmBtn() {
        confirmBtn.type = .GradientButton
    }
    
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        presenter?.didTapConfirmButton()
    }
}

extension DeliveryDetailsAddAdressViewController: DeliveryDetailsAddAdressViewProtocol {
    
}
