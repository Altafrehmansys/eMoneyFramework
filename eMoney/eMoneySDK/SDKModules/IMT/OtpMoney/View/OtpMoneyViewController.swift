//
//  OtpMoneyViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class OtpMoneyViewController: BaseViewController {

    // MARK: Properties

    var presenter: OtpMoneyPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension OtpMoneyViewController: OtpMoneyViewProtocol {
    
}
