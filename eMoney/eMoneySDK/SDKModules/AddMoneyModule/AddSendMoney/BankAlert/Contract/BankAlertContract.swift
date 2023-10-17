//
//  BankAlertContract.swift
//  etisalatWallet
//
//  Created by Muhammad Awais Anjum on 28/09/2022.
//  Copyright © 2022 Etisalat UAE. All rights reserved.
//

import Foundation
protocol BankAlertView: ViperView {
    func setupUI()
}

protocol BankAlertPresentation: ViperPresenter {
    func loadData()
    func dismiss()
}

protocol BankAlertUseCase: ViperInteractor {

}

protocol BankAlertOutput: AnyObject {
    
}

protocol BankAlertWireframe: ViperRouter {
    func dismiss()
}
