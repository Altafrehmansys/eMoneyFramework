//
//  ReEnterYourPINViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation
import UIKit

class ReEnterYourPINViewController: BaseViewController {

    @IBOutlet weak var btnNext: BaseButton!
    @IBOutlet weak var btnShowHide: UIButton!
    @IBOutlet weak var newPINTextField: StandardTextField!
    @IBOutlet weak var enterYourNewLabel: UILabel!
    // MARK: Properties

    var presenter: ReEnterYourPINPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpNavBar()
    }
    
    private func setUpNavBar(){
        self.navigationItem.setTitle(title:"Manage card", subtitle:"Re-enter new card PIN")
        self.createNavBackBtn()
    }
    
    @IBAction func btnShowHidePressed(_ sender: Any) {
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        
    }
}

extension ReEnterYourPINViewController: ReEnterYourPINViewProtocol {
    
}
