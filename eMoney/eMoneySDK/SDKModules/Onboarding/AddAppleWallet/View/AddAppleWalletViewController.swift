//
//  AddAppleWalletViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 27/04/2023.
//  
//

import Foundation
import UIKit

class AddAppleWalletViewController: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var imageViewCard: UIImageView!
    @IBOutlet weak var labelChoice: UILabel!
    @IBOutlet weak var buttonNotNow: UIButton!
    @IBOutlet weak var buttonAddToApple: UIButton!
    
    // MARK: Properties
    var cardColorEnum: SelectCardColor?
    var presenter: AddAppleWalletPresenterProtocol?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setViewInterface()
    }
    
    // MARK: Setting The View Interface
    func setViewInterface(){
        self.isHideNavigation(false)
        self.navigationItem.setTitle(title: "add_to_applewallet".localized)
        self.labelChoice.text = "wallet_choice".localized
        self.buttonNotNow.setTitle("not_now".localized, for: .normal)
        switch cardColorEnum {
        case .Red :
            imageViewCard.image = UIImage(named:"redCardVert")
        case .Gray :
            imageViewCard.image = UIImage(named:"silverCardVertical")
        case .Brown :
            imageViewCard.image = UIImage(named:"maroonCardVert")
        case .none:
            imageViewCard.image = UIImage(named:"maroonCardVert")
        }
        
    }
    
    @IBAction func notNowTapped(_ sender: Any) {
        presenter?.navigateToWelcomeScreen()
    }
}

// MARK: View Protocols
extension AddAppleWalletViewController: AddAppleWalletViewProtocol {
    
}
