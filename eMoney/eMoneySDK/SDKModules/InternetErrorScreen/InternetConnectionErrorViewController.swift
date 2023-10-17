//
//  InternetConnectionErrorViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 13/05/2023.
//

import UIKit

protocol InternetConnectionErrorViewControllerDelegate:AnyObject {
    func didInternetErrorTryAgainTapped()
    func didInternetErrorCancelTapped()
}

public class InternetConnectionErrorViewController: BaseViewController {

    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonCancel: BaseButton!
    @IBOutlet weak var buttonTryagain: BaseButton!
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    weak var delegate:InternetConnectionErrorViewControllerDelegate?
    
    // MARK: - Init
    public convenience init() {
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")
        self.init(nibName: "InternetConnectionErrorViewController", bundle: bundle)//Bundle(for: InternetConnectionErrorViewController.self))
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    func setupUI(){
        labelTitle.text = "no_internet_title".localized
        labelTitle.font = AppFont.appSemiBold(size: .h7)
        labelTitle.textColor = AppColor.eAnd_Black_80
        labelDescription.text = "no_internet_desc".localized
        labelDescription.font = AppFont.appRegular(size: .body3)
        labelDescription.textColor = AppColor.eAnd_Grey_100
        buttonTryagain.setTitle("try_again".localized, for: .normal)
        buttonCancel.setTitle("cancel".localized, for: .normal)
        
        buttonCancel.isHidden = true
    }

    @IBAction func tryAgainTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didInternetErrorTryAgainTapped()
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.delegate?.didInternetErrorCancelTapped()
        self.dismiss(animated: true)
    }

}
