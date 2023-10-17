//
//  ConfittiAnimation.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/06/2023.
//

import Lottie

final class ConfittiAnimation {
    
    private var animationName: String = ""
    private var animationView = LottieAnimationView()
    
//    override init() {
//        super.init()
//    }
    
    convenience init(name: String = "confitti", OnView view: UIView) {
        self.init()
        
        animationName = name
        
        let animation = LottieAnimation.named(name)
        animationView = LottieAnimationView(animation: animation)
        animationView.contentMode = .scaleAspectFill
        view.addSubview(animationView)
        
        animationView.backgroundColor = .white
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        animationView.loopMode = .loop
    }
    
    func play(completion: @escaping() -> Void) {
        animationView.play { _ in
            completion()
        }
    }
}
