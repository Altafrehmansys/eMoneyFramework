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
    @IBOutlet weak var mainView: UIView!
    
    
    // MARK: Properties

    var presenter: PinSuccessfulPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
       setViewInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setScreenSize(size: .halfScreen)
    }
    
    func setViewInterface(){
        presenter?.loadData()
        animationView.animation = LottieAnimation.named("confitti")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .repeat(2)
        animationView.play()
        if SDKColors.shared.flowName == SDKFlowName.changePin.rawValue {
            labelHeadingPin.text = "change_pin_success".localized
            labelPinDesc.text = "change_pin_success_desc".localized
        } else {
            labelHeadingPin.text = "forget_pin_success".localized
            labelPinDesc.text = "forget_pin_success_desc".localized
        }
        
        self.buttonDone.setTitle("done_btn_text".localized, for: .normal)
        mainView.layer.cornerRadius = 20
        mainView.layer.masksToBounds = true
    }
    
    // MARK: IB Actions
    
    @IBAction func buttonDoneTapped(_ sender: Any) {
        presenter?.moveToLoginView()
    }
    
    
}

extension PinSuccessfulViewController: PinSuccessfulViewProtocol {
    
}
