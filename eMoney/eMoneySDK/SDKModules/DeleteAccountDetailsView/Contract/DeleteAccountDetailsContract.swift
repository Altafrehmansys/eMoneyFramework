//
//  DeleteAccountDetailsContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation


protocol DeleteAccountDetailsViewDelegate: AnyObject {
    func didTapCloseButton()
    func didTapDeleteButton()
    func didTapCancelButton()
}

protocol DeleteAccountDetailsViewProtocol: ViperView {
    func setIconImage(title: String)
    func setTitleLabel(title: String)
    func setSubtitleLabel(title: String)
    func setDeleteButton(title: String)
    func setCancelButton(title: String)
}

protocol DeleteAccountDetailsPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol DeleteAccountDetailsInteractorProtocol: ViperInteractor {
    
}

protocol DeleteAccountDetailsInteractorOutputProtocol: AnyObject {
}

protocol DeleteAccountDetailsRouterProtocol: ViperRouter {
    func go(to route: DeleteAccountDetailsRouter.Route)
}
