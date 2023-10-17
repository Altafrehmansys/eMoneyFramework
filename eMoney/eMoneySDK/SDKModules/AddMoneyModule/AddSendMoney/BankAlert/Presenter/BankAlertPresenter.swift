//
//  BankAlertPresenter.swift
//  etisalatWallet
//
//  Created by Muhammad Awais Anjum on 28/09/2022.
//  Copyright © 2022 Etisalat UAE. All rights reserved.
//

import Foundation

class BankAlertPresenter : NSObject {
    
    weak var view : BankAlertView?
    var router : BankAlertRouter?
    var interactor : BankAlertInteractor?
}

extension BankAlertPresenter : BankAlertPresentation {
    
    func loadData() {
        view?.setupUI()
    }
    
    func dismiss(){
        router?.dismiss()
    }
}

extension BankAlertPresenter : BankAlertOutput {
    
}
