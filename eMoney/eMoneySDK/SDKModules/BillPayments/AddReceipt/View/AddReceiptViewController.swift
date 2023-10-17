//
//  AddReceiptViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 07/06/2023.
//  
//

import Foundation
import UIKit

class AddReceiptViewController: BaseViewController {

    // MARK: Properties

    var presenter: AddReceiptPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension AddReceiptViewController: AddReceiptViewProtocol {
    
}
