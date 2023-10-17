//
//  BillAccountDetailsRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//  
//

import ContactsUI
import UIKit

class BillAccountDetailsRouter {

    enum Route {
        case addNewAccount
        case navigateBillEnterAmount(input:BillAccountDetailsParameters)
        case contacts(delegate: CNContactPickerDelegate)
        case navigateToSelectPlan(input:BillAccountDetailsParameters)
        case mobileInternationalSelectPlan(input:BillAccountDetailsParameters)
        case loadBottomSheet(dataSource:[StandardCellModel])
        case additionalInfoSheet(dataSource: [StandardCellModel], actions: [BaseButton])
        
        
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(navTitle:String,selecteItem:ListItems?,billType:BillsAnsTopUpType, codeList: [String]? = []) -> BillAccountDetailsViewController {
        let viewController = BillAccountDetailsViewController.instantiate(fromAppStoryboard: .BillAccountDetails)
        let viewData = BillAccountDetailsViewData(navTitle: navTitle, selectedItem: selecteItem, selectItemType: billType, countryCodesList: codeList)
        let presenter = BillAccountDetailsPresenter(viewData: viewData)
        let router = BillAccountDetailsRouter()
        let interactor = BillAccountDetailsInteractor()

        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
//        presenter.navTitle = navTitle
//        presenter.selectedItem = selecteItem
//        presenter.selectItemType = billType
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension BillAccountDetailsRouter: BillAccountDetailsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .addNewAccount:
            let vc = AddMobileBillAccountRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .navigateBillEnterAmount(let input):
            let vc = AddBillsEnterAmountRouter.setupModule(input: input)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case let .contacts(delegate):
            let contactsPikcerView = CNContactPickerViewController()
            contactsPikcerView.delegate = delegate
            self.view?.present(contactsPikcerView, animated: true, completion: nil)
        case .navigateToSelectPlan(let input):
            let vc = SelectPlanRouter.setupModule(input: input)
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .mobileInternationalSelectPlan(let input):
            let vc = BillSelectPlanContainerViewRouter.setupModule(input: input)
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .loadBottomSheet(let dataSource):
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
        case .additionalInfoSheet(let dataSource,let actions):
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
        }
        
    }
}
