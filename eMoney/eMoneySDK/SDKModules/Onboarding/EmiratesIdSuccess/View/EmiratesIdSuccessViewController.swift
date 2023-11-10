//
//  PinSuccessfulViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 17/07/2023.
//  
//

import Foundation
import UIKit
import Lottie

class EmiratesIdSuccessViewController: BaseViewController {

    // MARK: Outlets
    
    @IBOutlet weak var imageViewTick: UIImageView!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    @IBOutlet weak var buttonDone: BaseButton!
    @IBOutlet weak var labelHeadingPin: UILabel!
    
    
    // MARK: Properties

    var presenter: EmiratesIdSuccessPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
       setViewInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .onChangeTopCloseButton, object: nil, userInfo: ["isShow":true])
    }
    
    func setViewInterface(){
        presenter?.loadData()
        animationView.animation = LottieAnimation.named("confitti")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .repeat(2)
        animationView.play()
        labelHeadingPin.text = "update_emirateid_success".localized
        
        self.buttonDone.setTitle("done_btn_text".localized, for: .normal)
    }
    
    // MARK: IB Actions
    
    @IBAction func buttonDoneTapped(_ sender: Any) {
        presenter?.moveToLoginView()
    }
}

extension EmiratesIdSuccessViewController: EmiratesIdSuccessViewProtocol {
    
}
