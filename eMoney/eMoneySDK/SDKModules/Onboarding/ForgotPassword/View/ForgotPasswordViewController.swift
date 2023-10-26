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
    
    
    // MARK: Properties

    var presenter: ForgotPasswordPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        presenter?.loadData()
    }
    @IBAction func buttonDoneTapped(_ sender: Any) {
        presenter?.backToLogin()
    }
    
    private func setUI() {
        labelPin.text = "emoney_account_created_success".localized
        labelPinDesc.text = "emoney_account_created_success_desc".localized
        buttonDone.setTitle("ok".localized, for: .normal)
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewProtocol {
    
}
