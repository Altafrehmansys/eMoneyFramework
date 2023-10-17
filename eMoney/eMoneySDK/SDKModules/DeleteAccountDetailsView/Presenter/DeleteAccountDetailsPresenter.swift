//
//  DeleteAccountDetailsPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation

class DeleteAccountDetailsPresenter {

    // MARK: Properties
    weak var view: DeleteAccountDetailsViewProtocol?
    var router: DeleteAccountDetailsRouterProtocol?
    var interactor: DeleteAccountDetailsInteractorProtocol?
    var viewData: DeleteAccountDetailsViewData?
}

extension DeleteAccountDetailsPresenter: DeleteAccountDetailsPresenterProtocol {
    
    func loadData() {
        setDataToView()
    }
    
    private func setDataToView() {
        view?.setIconImage(title: viewData?.deleteIconName ?? "")
        view?.setTitleLabel(title: viewData?.deleteTitle ?? "")
        view?.setSubtitleLabel(title: viewData?.deleteSubTitle ?? "")
        view?.setDeleteButton(title: viewData?.deleteBtn ?? "")
        view?.setCancelButton(title: viewData?.cancelBtn ?? "")
    }
}

extension DeleteAccountDetailsPresenter: DeleteAccountDetailsInteractorOutputProtocol {
    
}
