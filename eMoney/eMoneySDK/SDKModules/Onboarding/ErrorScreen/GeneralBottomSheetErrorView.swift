//
//  GeneralBottomSheetErrorView.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 11/05/2023.
//

import UIKit
import SwiftMessages

protocol GeneralBottomSheetErrorViewDelegate:AnyObject{
    func tryAgainBtnTapped(index: Int)
    func closeBtnTapped()
    func secondryBtnTapped()
}

extension GeneralBottomSheetErrorViewDelegate {
    func closeBtnTapped() {}
    func secondryBtnTapped() {}
}

class GeneralBottomSheetErrorView: MessageView {

    @IBOutlet weak var imageViewError: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var btnTryAgain: BaseButton!
    @IBOutlet weak var secondryButton: BaseButton! {
        didSet {
            secondryButton.isHidden = true
            secondryButton.type = .PlainButton
        }
    }
    
    weak var delegate:GeneralBottomSheetErrorViewDelegate?
    private var index: Int = 0
    
    func setupUI(){
        self.titleLbl.font = AppFont.appSemiBold(size: .h7)
        self.messageLbl.font = AppFont.appRegular(size: .body3)
        
        self.titleLbl.textColor = AppColor.eAnd_Black_80
        self.messageLbl.textColor = AppColor.eAnd_Grey_100
    }
    func configureView(index: Int = 0, title:String, message:String, actionBtnTitle:String, secondryButtonTitle: String? = nil, imageName: String? = "danger") {
        self.index = index
        self.titleLbl.text = title
        self.messageLbl.text = message
        imageViewError.image = UIImage(named: imageName ?? "danger")
        btnTryAgain.setTitle(actionBtnTitle, for: .normal)
        if let secondryButtonTitle {
            secondryButton.setTitle(secondryButtonTitle, for: .normal)
            secondryButton.isHidden = false
        } else {
            secondryButton.isHidden = true
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.delegate?.closeBtnTapped()
        SwiftMessages.hide()
    }
    
    @IBAction func tryAgainTapped(_ sender: Any) {
        self.delegate?.tryAgainBtnTapped(index: self.index)
        SwiftMessages.hide()
    }
    
    @IBAction func secondryButtonTapped(_ sender: Any) {
        self.delegate?.secondryBtnTapped()
        SwiftMessages.hide()
    }
}
