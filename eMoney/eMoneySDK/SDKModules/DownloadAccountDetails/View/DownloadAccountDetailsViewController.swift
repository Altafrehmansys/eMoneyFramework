//
//  DownloadAccountDetailsViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation
import UIKit

class DownloadAccountDetailsViewController: BaseViewController {

    // MARK: Properties

    var presenter: DownloadAccountDetailsPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension DownloadAccountDetailsViewController: DownloadAccountDetailsViewProtocol {
    
}
