//
//  DEWATransferDetailsViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 06/06/2023.
//  
//

import Foundation
import UIKit

class DEWATransferDetailsViewController: BaseViewController {

    // MARK: Properties

    var presenter: DEWATransferDetailsPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
    }
    
    private func setUI() {
        setNavigationController()
    
    }
    private func setNavigationController() {
        self.navigationItem.setTitle(title: "DEWA - Office", subtitle: "1681623465132")
        createNavBackBtn()
    }
}

extension DEWATransferDetailsViewController: DEWATransferDetailsViewProtocol {
    
}
