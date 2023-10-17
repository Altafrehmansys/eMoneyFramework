//
//  BaseNavigationController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 16/03/2023.
//

import UIKit

class BaseNavigationController: UINavigationController {

    var isBlackNavBar:Bool = false {
        didSet{
            if isBlackNavBar {
                navigationBarWithBlackBackground()
            }else{
                navigationBarWithWhiteBackground()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .white
//        appearance.shadowColor = .clear
//        appearance.backgroundImage = UIImage(named: "navigation-background")
//        navigationBar.standardAppearance = appearance
//        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBarWithWhiteBackground()
        
    }
    
    func setupNavigationWithBackground(image: String) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.backgroundImage = UIImage(named: image)
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupNavigationWithClearBackground() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    func navigationBarWithBlackBackground(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.shadowColor = .clear
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    func navigationBarWithWhiteBackground(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}


