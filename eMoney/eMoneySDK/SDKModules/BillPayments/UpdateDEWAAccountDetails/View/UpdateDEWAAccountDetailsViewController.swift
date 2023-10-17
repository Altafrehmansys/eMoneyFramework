//
//  UpdateDEWAAccountDetailsViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation
import UIKit

class UpdateDEWAAccountDetailsViewController: BaseViewController {
    
    
    // MARK: Outlets
    @IBOutlet private weak var providerImage: UIImageView!
    @IBOutlet private weak var providerName: UILabel!
    @IBOutlet private weak var easypayNumberTextField: StandardTextField!
    @IBOutlet private weak var nameTextField: StandardTextField!
    @IBOutlet private weak var contineButton: UIButton!

    // MARK: Properties

    var presenter: UpdateDEWAAccountDetailsPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
    }
    
    private func setUI() {
        setEasypayNickname()
        setEasypayNumberTextField()
        setFonts()
        setContinueButton()
    }
    private func setEasypayNumberTextField() {
        easypayNumberTextField.entryType = .decimal
        easypayNumberTextField.trailingButtonImage =  "info-circle"
        easypayNumberTextField.trailingButtonTappedCallback = { [weak self] in
          //  self?.presenter?.infoBtnTapped()
        }
        easypayNumberTextField.placeholder = "Enter EasyPay number"
    }
    
    private func setEasypayNickname() {
        nameTextField.placeholder = "Name/Nickname (optional)"
    }
    
    private func setFonts() {
        providerName.font = AppFont.appSemiBold(size: .body2)
    }
    
    private func setContinueButton() {
        contineButton.setTitle("Update account details", for: .normal)
    }
}

extension UpdateDEWAAccountDetailsViewController: UpdateDEWAAccountDetailsViewProtocol {
    
}
