//
//  BillDEWAWalletBalanceViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import Foundation
import UIKit

class BillDEWAWalletBalanceViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var providerImage: UIImageView!
    @IBOutlet private weak var provierNameLabel: UILabel!
    @IBOutlet private weak var providerNumber: UILabel!
    @IBOutlet private weak var nextButtonContainer: UIView!
    
    // MARK: Properties

    var presenter: BillDEWAWalletBalancePresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
    }
    
    private func setUI() {
        setNavigationController()
        setFonts()
        setNextButton()
    }
    private func setNavigationController() {
        self.navigationItem.setTitle(title: "DEWA", subtitle: "Wallet balance AED 440.90")
        createNavBackBtn()
    }
    private func setFonts() {
        provierNameLabel.font = AppFont.appRegular(size: .body3)
        providerNumber.font = AppFont.appRegular(size: .body4)
    }
    
    private func setNextButton() {
        nextButtonContainer.addGradient(colors: [AppColor.eAnd_Red_Gradient_Start, AppColor.eAnd_Red_Gradient_End], locations: [0, 1], startPoint: CGPoint(x: 0, y: 0.5), endPoint:  CGPoint(x: 1.0, y: 0.5))
        nextButtonContainer.clipsToBounds = true
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let vc = DEWASendMoneyPaymentDetailsRouter.setupModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BillDEWAWalletBalanceViewController: BillDEWAWalletBalanceViewProtocol {
    
}
