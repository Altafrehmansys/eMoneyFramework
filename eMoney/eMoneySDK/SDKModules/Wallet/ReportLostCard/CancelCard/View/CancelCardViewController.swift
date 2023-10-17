//
//  CancelCardViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 14/07/2023.
//  
//

import Foundation
import UIKit

class CancelCardViewController: BaseViewController {

    // MARK: Properties

    @IBOutlet weak var accountCancelLabel: UILabel!
    @IBOutlet weak var btnNotNowLater: BaseButton!
    @IBOutlet weak var btnIssueNewCard: BaseButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cancelLabel: UILabel!
    @IBOutlet weak var cardCancelViw: UIView!
    @IBOutlet weak var cardImgView: UIImageView!
    var presenter: CancelCardPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpScreenUI()
    }
    
    func setUpScreenUI(){
        btnIssueNewCard.type = .GradientButton
        btnIssueNewCard.setTitle("Issue new e& money card", for: .normal)
        
        btnNotNowLater.type = .PlainButton
        btnNotNowLater.setTitle("Not now, later", for: .normal)
        accountCancelLabel.isHidden = true
        accountCancelLabel.text = "ACCOUNT CANCELLED"
        accountCancelLabel.font = AppFont.appRegular(size:.body3)
        accountCancelLabel.textColor = AppColor.eAnd_Maroon
        
        cancelLabel.text = "Card cancelled"
        cancelLabel.font = AppFont.appSemiBold(size:.body2)
        cancelLabel.textColor = AppColor.eAnd_Black_80
        
        
        statusLabel.text = "Your e& money card is cancelled"
        statusLabel.font = AppFont.appSemiBold(size: .h7)
        statusLabel.textColor = AppColor.eAnd_Black_80
        
        descriptionLabel.text = "You can reissue a new card which will be updated on your digital wallet."
        descriptionLabel.font = AppFont.appLight(size: .body2)
        descriptionLabel.textColor = AppColor.eAnd_Black_80
    }
    
    @IBAction func btnIssueNewCardPressed(_ sender: Any) {
        
    }
    
    @IBAction func btnNotNowPressed(_ sender: Any) {
        self.dismiss(animated: true) {
           UIApplication.getTopViewController()?.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension CancelCardViewController: CancelCardViewProtocol {
    
}
