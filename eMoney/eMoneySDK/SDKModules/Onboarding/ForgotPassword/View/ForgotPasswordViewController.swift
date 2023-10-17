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
        presenter?.loadData()
    }
    @IBAction func buttonDoneTapped(_ sender: Any) {
        presenter?.backToLogin()
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewProtocol {
    
}
