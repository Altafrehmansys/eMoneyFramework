//
//  ParkingSMSCopyViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation
import UIKit

class ParkingSMSCopyViewController: BaseViewController {
    @IBOutlet weak var btnReturn:BaseButton!
    @IBOutlet weak var lblNote:UILabel!
    @IBOutlet weak var lblCode:UILabel!
    // MARK: Properties

    var presenter: ParkingSMSCopyPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    @IBAction func returnToRoot(_ sender:UIButton) {
        self.dismiss(animated: true) {
            if let vc = UIApplication.getTopViewController()?.navigationController?.viewControllers.first(where: { $0 is BillsAndTopsUpViewController}) as? BillsAndTopsUpViewController {
                UIApplication.getTopViewController()?.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    @IBAction func didSelectCopy(_ sender:UIButton) {
        UIPasteboard.general.string = self.presenter?.model?.data?.messageText ?? ""
        
    }
}

extension ParkingSMSCopyViewController: ParkingSMSCopyViewProtocol {
    func setupUI() {
        self.btnReturn.type = .GradientButton
        self.btnReturn.setTitle("Return to bills & top ups", for: .normal)
        self.btnReturn.titleLabel?.font = AppFont.appSemiBold(size: .body3)
        self.presenter?.openMessagesApp()
    }
}
