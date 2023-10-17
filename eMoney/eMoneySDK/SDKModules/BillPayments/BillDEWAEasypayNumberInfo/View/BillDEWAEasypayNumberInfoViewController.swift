//
//  BillDEWAEasypayNumberInfoViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 01/06/2023.
//  
//

import Foundation
import UIKit

class BillDEWAEasypayNumberInfoViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var sheetContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    // MARK: Properties

    var presenter: BillDEWAEasypayNumberInfoPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    private func setUI() {
        setSheetContainerView()
        setFonts()
    }
    
    private func setSheetContainerView() {
        sheetContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setFonts() {
        titleLabel.font = AppFont.appRegular(size: .body2)
        subTitleLabel.font = AppFont.appRegular(size: .body3)
    }
    
    @IBAction func closeBtnTapped() {
        dismiss(animated: false)
    }
}


extension BillDEWAEasypayNumberInfoViewController: BillDEWAEasypayNumberInfoViewProtocol {
    
}
