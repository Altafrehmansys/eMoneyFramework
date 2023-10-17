//
//  SetUpNewPINViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation
import UIKit

class SetUpNewPINViewController: BaseViewController {
    @IBOutlet weak var enterYourLabel: UILabel!
    
    @IBOutlet weak var pinTextField: StandardTextField!
    // MARK: Properties

    @IBOutlet weak var btnStrongPIN: UIButton!
    @IBOutlet weak var btnShowHide: UIButton!
    var presenter: SetUpNewPINPresenterProtocol?

    @IBOutlet weak var btnNext: BaseButton!
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpNavBar()
    }
    
    private func setUpNavBar(){
        self.navigationItem.setTitle(title:"Manage card", subtitle:"Set up your new card PIN")
        self.createNavBackBtn()
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        self.presenter?.navigateToConfirmCardPIN()
    }
    
}

extension SetUpNewPINViewController: SetUpNewPINViewProtocol {
    
}
