//
//  ToastMessageView.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 23/08/2023.
//

import Foundation
import SwiftMessages
import UIKit

protocol ToastMessageViewDelegate:AnyObject{
    func closeBtnTapped()
}

extension ToastMessageViewDelegate {
    func closeBtnTapped() {}
}

class ToastMessageView: MessageView {

    @IBOutlet weak var leadingImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var closeButton: BaseButton!
    
    @IBOutlet weak var containerView: UIView!
    
    weak var delegate:ToastMessageViewDelegate?
    
    func setupUI() {
        
        containerView.cornerRadius = 12
        containerView.addShadow(shadowOpacity: 1,
                                shadowRadius: 12,
                                shadowOffset: CGSize(width: 0, height: 4),
                                shadowColor: UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.5))
        
        self.titleLbl.font = AppFont.appSemiBold(size: .body3)
//        self.messageLbl.font = AppFont.appRegular(size: .body3)
        
        self.titleLbl.textColor = AppColor.eAnd_Black_80
//        self.messageLbl.textColor = AppColor.eAnd_Grey_100
    }
    
    func configureView(image: String? = nil, title: String, message:String? = nil) {
        self.titleLbl.text = title
//        self.messageLbl.text = message
        if let image {
            leadingImageView.image = UIImage(named: image)
            leadingImageView.isHidden = false
        } else {
            leadingImageView.isHidden = true
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.delegate?.closeBtnTapped()
        SwiftMessages.hide()
    }
}
