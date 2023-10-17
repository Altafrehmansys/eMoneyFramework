//
//  ReportLostCardViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 14/07/2023.
//  
//

import Foundation
import UIKit

class ReportLostCardViewController: BaseViewController {

    @IBOutlet weak var btnCancelCard: BaseButton!
    @IBOutlet weak var cancelLimitLabel: UILabel!
    @IBOutlet weak var cardNumberTextField: StandardTextField!
    // MARK: Properties

    var presenter: ReportLostCardPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpScreenUI()
        setupNavigatioBar()
    }
    
    private func setupNavigatioBar() {
        self.createNavBackBtn()
        self.navigationItem.setTitle(title:"Manage card", subtitle:"Report a lost card")
    }
    
    func setUpScreenUI(){
        
        btnCancelCard.type = .GradientButton
        btnCancelCard.setTitle("Cancel card", for: .normal)
        cancelLimitLabel.text = "You can only cancel your e& money card 3 times. You have 2 cancellations left."
        cancelLimitLabel.font = AppFont.appRegular(size: .body4)
        cancelLimitLabel.textColor = AppColor.eAnd_Black_80
    }
    
    @IBAction func btnCancelCardPressed(_ sender: Any) {
        self.presenter?.presentReportCardSuccessScreen()
    }
    
}

extension ReportLostCardViewController: ReportLostCardViewProtocol {
    
}
