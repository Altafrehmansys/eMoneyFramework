//
//  BillDEWAAccountDetailsViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 01/06/2023.
//  
//

import Foundation
import UIKit

class BillDEWAAccountDetailsViewController: BaseViewController {

    // MARK: Outlets
    @IBOutlet private weak var providerImage: UIImageView!
    @IBOutlet private weak var providerName: UILabel!
    @IBOutlet private weak var easypayNumberTextField: StandardTextField!
    @IBOutlet private weak var nameTextField: StandardTextField!
    @IBOutlet private weak var saveDataLabel: UILabel!
    @IBOutlet private weak var contineButton: UIButton!


    // MARK: Properties

    var presenter: BillDEWAAccountDetailsPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
    }
    
    private func setUI() {
        setNavigationController()
        setEasypayNumberTextField()
        setEasypayNickname()
    }
    private func setNavigationController() {
        self.navigationItem.setTitle(title: "Home utilities", subtitle: "Account details")
        createNavBackBtn()
    }
    
    private func setEasypayNumberTextField() {
        easypayNumberTextField.entryType = .decimal
        easypayNumberTextField.trailingButtonImage =  "info-circle"
        easypayNumberTextField.trailingButtonTappedCallback = { [weak self] in
            self?.presenter?.infoBtnTapped()
        }
        easypayNumberTextField.placeholder = "Enter EasyPay number"
    }
    
    private func setEasypayNickname() {
        nameTextField.placeholder = "Name/Nickname (optional)"
    }
    
    private func setFonts() {
        providerName.font = AppFont.appSemiBold(size: .body2)
        saveDataLabel.font = AppFont.appRegular(size: .body4)
        
    }
    
    @IBAction func contineToPayBille(_ sender: UIButton) {
        presenter?.didContinueButtonTapped()
    }
}

extension BillDEWAAccountDetailsViewController: BillDEWAAccountDetailsViewProtocol {
    
}
