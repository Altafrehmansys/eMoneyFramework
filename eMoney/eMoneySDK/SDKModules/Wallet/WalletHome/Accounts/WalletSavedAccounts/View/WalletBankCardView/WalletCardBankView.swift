//
//  WalletCardBankView.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 11/07/2023.
//

import UIKit

class WalletCardBankView: UIView {

    @IBOutlet private weak var cardIcon: UIImageView!
    @IBOutlet private weak var cardNameLabel: UILabel!
    @IBOutlet private weak var cardNumberLabel: UILabel!
    @IBOutlet private weak var bottomSeprator: UIView!
    
    var contentView: UIView!
    var nibName: String {
        return String(describing: type(of: self))
    }
    
    //MARK:
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
//        let bundle = Bundle(for: WalletCardBankView.self)
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")
        contentView = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: self).first as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func hideBottomSeprator() {
        bottomSeprator.isHidden = true
    }
}
