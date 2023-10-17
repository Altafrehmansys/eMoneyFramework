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

class PinSuccessfulViewController: BaseViewController {

    // MARK: Outlets
    
    @IBOutlet weak var imageViewTick: UIImageView!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    @IBOutlet weak var buttonDone: BaseButton!
    @IBOutlet weak var labelPinDesc: UILabel!
    @IBOutlet weak var labelHeadingPin: UILabel!
    
    
    // MARK: Properties

    var presenter: PinSuccessfulPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
       setViewInterface()
    }
    
    func setViewInterface(){
        presenter?.loadData()
        animationView.animation = LottieAnimation.named("confitti")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .repeat(2)
        animationView.play()
        labelHeadingPin.text = "forget_pin_success".localized
        labelPinDesc.text = "forget_pin_success_desc".localized
        self.buttonDone.setTitle("done_btn_text".localized, for: .normal)
    }
    
    // MARK: IB Actions
    
    @IBAction func buttonDoneTapped(_ sender: Any) {
        presenter?.moveToLoginView()
    }
    
    
}

extension PinSuccessfulViewController: PinSuccessfulViewProtocol {
    
}
