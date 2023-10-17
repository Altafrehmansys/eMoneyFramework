//
//  AutoPayViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import Foundation
import UIKit

class AutoPayViewController: BaseViewController {

    // MARK: Properties

    var presenter: AutoPayPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension AutoPayViewController: AutoPayViewProtocol {
    
}
