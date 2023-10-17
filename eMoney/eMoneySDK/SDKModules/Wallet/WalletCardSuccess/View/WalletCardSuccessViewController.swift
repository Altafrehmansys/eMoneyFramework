//
//  WalletCardSuccessViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation
import UIKit
import Lottie

class WalletCardSuccessViewController: BaseViewController {
    
    @IBOutlet weak var animatedBGView:LottieAnimationView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var headingLabel:UILabel!
    @IBOutlet weak var btnReturn: BaseButton!
    // MARK: Properties

    var presenter: WalletCardSuccessPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        self.setAnimation(self.animatedBGView,
                            name: "confitti")
//        self.setAnimation(self.successAnimatedTickView,
//                            name: "tick-circle",
//                          loopMode: .repeat(2))
        setFonts()
        setLocalizations()
        
    }
    
    private func setFonts() {
        titleLabel.font = AppFont.appSemiBold(size: .h7)
    headingLabel.font = AppFont.appLight(size: .body2)
    }
    
    private func setLocalizations() {
        titleLabel.text = Strings.Wallet.wallet_success_title
        headingLabel.text = Strings.Wallet.wallet_success_subTitle
        btnReturn.setTitle(Strings.Wallet.done, for: .normal)
    }
    func setAnimation(_ animatedView:LottieAnimationView,
                        name:String,
                        loopMode:LottieLoopMode = .loop){
        animatedView.animation = LottieAnimation.named(name)
        animatedView.contentMode = animatedView == self.animatedBGView ? .scaleAspectFit : .scaleAspectFill
        animatedView.loopMode = .repeat(3)
        animatedView.play()
    }
    @IBAction func didTapReturn(_ sender:UIButton) {
        self.isHideNavigation(false)
        self.dismiss(animated: true)
        
    }
}

extension WalletCardSuccessViewController: WalletCardSuccessViewProtocol {
    
}
