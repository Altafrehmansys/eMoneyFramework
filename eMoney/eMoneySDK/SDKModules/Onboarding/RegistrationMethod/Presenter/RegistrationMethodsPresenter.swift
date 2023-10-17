//
//  RegistrationMethodsPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import Foundation

final class RegistrationMethodsPresenter: RegistrationMethodsPresenterProtocol {
    
    // MARK: - Attributes
    weak var view: RegistrationMethodsViewProtocol?
    var interactor: RegistrationMethodsInteractorProtocol
    var router: RegistrationMethodsRouterProtocol
    
    var dataSource: [StandardCellModel] = []
    var cellAction: StandardCellActions?
    
    init(view: RegistrationMethodsViewProtocol, interactor: RegistrationMethodsInteractorProtocol, router: RegistrationMethodsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setupUI()
        setupCellActions()
    }
}

// MARK: - Private Methods
extension RegistrationMethodsPresenter {
    
}

// MARK: - Prepare Datasource
extension RegistrationMethodsPresenter {
    func makeDataSource(data:[LookupRegistrationData]) {
        let labelCellModel = GenericSingleLabelCellModel(content: "registration_choose_method".localized)
        dataSource.append(labelCellModel)
        
        for item in data {
            let optionCellModel1 = RegisterOptionCellModel(actions: cellAction, title: item.lookupValue ?? "", subtitle: item.lookupDesc ?? "", image: item.imgUrl ?? "", type: item.lookupCode ?? "")
            dataSource.append(optionCellModel1)
        }
//        let optionCellModel1 = RegisterOptionCellModel(actions: cellAction, title: "Emirates smart card ID", subtitle: "Take pictures of both sides", image: "emeraits-icon", type: .smartCardId)
//        dataSource.append(optionCellModel1)
//
//        let optionCellModel2 = RegisterOptionCellModel(actions: cellAction, title: "UAE Pass mobile app", subtitle: "Open the app and verify registration", image: "fingerprint", type: .uaePass)
//        dataSource.append(optionCellModel2)
        view?.reloadData()
    }
    
    private func setupCellActions() {
        cellAction = StandardCellActions {[weak self] index, model in
            if let cellModel = model as? RegisterOptionCellModel {
                switch cellModel.type {
                case .emiratesId:
                    print("Smart card id tapped")
                    self?.router.go(to: .captureIdentity)
                case .uaePass:
                    print("UAE pass tapped")
                }
            }
        }
    }
    
    func navigateToEnterEmail(){
        router.go(to: .enterEmail)
    }
    func lookupRequestToServer(lookupType: String) {
        Loader.shared.showFullScreen()
        interactor.lookupApiCalltoServer(lookupType: lookupType)
    }
}

// MARK: - RegistrationMethodsInteractorOutputProtocol
extension RegistrationMethodsPresenter: RegistrationMethodsInteractorOutputProtocol {
    func lookupApiCallError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
    }
    
    func lookupApiCallResponse(response: LookupRegistrationMethodsModel?) {
        Loader.shared.hideFullScreen()
        if let data = response?.data {
            makeDataSource(data:data)
        }
        
    }
}
