//
//  AddMobileBillAccountPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 22/05/2023.
//  
//

import Foundation

class AddMobileBillAccountPresenter {

    // MARK: Properties

    weak var view: AddMobileBillAccountViewProtocol?
    var router: AddMobileBillAccountRouterProtocol?
    var interactor: AddMobileBillAccountInteractorProtocol?
    var celAction: StandardCellActions? = nil
    
}

extension AddMobileBillAccountPresenter: AddMobileBillAccountPresenterProtocol {
   
    
    
    func loadData() {
        view?.setupUI()
        setCellAction()
    }
    
    private func setCellAction() {
        
        celAction = StandardCellActions{ index, model in
            if let cellModel = model as? RegisterOptionCellModel {
                switch cellModel.type {
                case .emiratesId:
                    print("Smart card id tapped")
                    self.router?.go(to: .captureIdentity)
                case .uaePass:
                    print("UAE pass tapped")
                }
            }
        }
    }
    
    func navigateToMobileBillEnterAmountScreen() {
        self.router?.go(to: .moveToShowMobileAmountScreen)
    }
    
    func showIdentityVerificationBottomSheet(){
        var dataSource = [StandardCellModel]()
        let titleCell = GenericSingleLabelCellModel(content: "Identity verification required", font:AppFont.appSemiBold(size:.body2), alignment: .center)
        dataSource.append(titleCell)
        
        let titleCell2 = GenericSingleLabelCellModel(content: "Choose one of the below methods to complete your registration", alignment: .center)
        dataSource.append(titleCell2)
        
        let optionCellModel1 = RegisterOptionCellModel(actions: self.celAction, title: "Emirates smart card ID", subtitle: "Take pictures of both sides", image: "emeraits-icon", type: "REG_EID")
                dataSource.append(optionCellModel1)
        
        let optionCellModel2 = RegisterOptionCellModel(actions: self.celAction, title: "UAE Pass mobile app", subtitle: "Open the app and verify registration", image: "fingerprint",type:"REG_EID")
                dataSource.append(optionCellModel2)
        
        
        let optionCellModel3 = RegisterOptionCellModel(actions: self.celAction, title: "UAE Pass mobile app", subtitle: "Open the app and verify registration", image: "fingerprint",type:"REG_EID")
                dataSource.append(optionCellModel3)
        
        let optionCellModel4 = RegisterOptionCellModel(actions: self.celAction, title: "UAE Pass mobile app", subtitle: "Open the app and verify registration", image: "fingerprint",type:"REG_EID")
                dataSource.append(optionCellModel4)
        
        let optionCellModel5 = RegisterOptionCellModel(actions: self.celAction, title: "UAE Pass mobile app", subtitle: "Open the app and verify registration", image: "fingerprint",type:"REG_EID")
                dataSource.append(optionCellModel5)
        
        let optionCellModel6 = RegisterOptionCellModel(actions: self.celAction, title: "UAE Pass mobile app", subtitle: "Open the app and verify registration", image: "fingerprint",type:"REG_EID")
                dataSource.append(optionCellModel6)
        
        
        let optionCellModel7 = RegisterOptionCellModel(actions: self.celAction, title: "UAE Pass mobile app", subtitle: "Open the app and verify registration", image: "fingerprint",type:"REG_EID")
                dataSource.append(optionCellModel7)
        
        let optionCellModel8 = RegisterOptionCellModel(actions: self.celAction, title: "UAE Pass mobile app", subtitle: "Open the app and verify registration", image: "fingerprint",type:"REG_EID")
                dataSource.append(optionCellModel8)
        
        
        
        self.router?.go(to: .showIdentityVerficationBottomSheet(dataSource: dataSource))
    }
    
}

extension AddMobileBillAccountPresenter: AddMobileBillAccountInteractorOutputProtocol {

}

