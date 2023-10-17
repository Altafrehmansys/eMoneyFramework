//
//  SplashAnimation.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 09/05/2023.
//

import Foundation
import Lottie

class SplashAnimation: NSObject {
    
    private var animationName: String = ""
    
    private var animationView = LottieAnimationView()
    
    override init() {
        super.init()
    }
    
     convenience init(name:String = "eWallet_2022_Splash" ,OnView view:UIView) {
        self.init()
        
        animationName = name
        
        let animation = LottieAnimation.named(name)
        
         animationView = LottieAnimationView(animation: animation)
         animationView.contentMode = .scaleAspectFill
        view.addSubview(animationView)
        //animationView.loopMode = .loop
        
       // animationView.play()
        
      //  animationView.animation = animation
        
       // view.addSubview(animationView)
        
        
        animationView.backgroundColor = .white
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        animationView.loopMode = .playOnce
    }
        
    func play(completion:@escaping()-> Void){
         animationView.play {_ in
             print("complete")
             completion()
         }
    }
}
