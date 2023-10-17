//
//  KickstartSuccessViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/05/2023.
//  
//

import Foundation
import UIKit
import Lottie

class KickstartSuccessViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet weak var imageViewEmoney: UIImageView!
    @IBOutlet weak var labelKickStart: UILabel!
    @IBOutlet weak var imageViewBg: UIImageView!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var buttonCross: UIButton!
    @IBOutlet weak var animatonView1: LottieAnimationView!
    @IBOutlet weak var animatonView2: LottieAnimationView!
    // MARK: Properties

    var presenter: KickstartSuccessPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setViewInterface()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.presenter?.navigateToHome()
        }
    }
    func setupAnimation(){
        animatonView1.animation = LottieAnimation.named("confitti")
        animatonView1.contentMode = .scaleAspectFit
        animatonView1.loopMode = .repeat(2)
        animatonView1.play()
        
        animatonView2.animation = LottieAnimation.named("confitti")
        animatonView2.contentMode = .scaleAspectFit
        animatonView2.loopMode = .repeat(2)
        animatonView2.play()
    }
    
    // MARK: Setting View Interface
    func setViewInterface(){
        labelKickStart.text = "kick_start_journey".localized
        labelKickStart.textColor = AppColor.eAnd_Black_80
        labelKickStart.font = AppFont.appSemiBold(size: .h7)
        labelDesc.text = "kick_start_journey_desc".localized
        labelDesc.textColor = AppColor.eAnd_Grey_100
        labelDesc.font = AppFont.appRegular(size: .body3)
        imageViewEmoney.image = UIImage(named:"ic_e&money")
    }
    @IBAction func buttonCrossTapped(_ sender: Any) {
        self.presenter?.navigateToHome()
    }
}

extension KickstartSuccessViewController: KickstartSuccessViewProtocol {
    
}
