//
//  PaymentMachinesPresenter.swift
//  e&money
//
//  Created by Qamar Iqbal on 02/05/2023.
//  
//

import Foundation

class PaymentMachinesPresenter {

    // MARK: Properties
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    weak var view: PaymentMachinesViewProtocol?
    var router: PaymentMachinesRouterProtocol?
    var interactor: PaymentMachinesInteractorProtocol?
    
    var getLocationNearByType: String = ""
}

extension PaymentMachinesPresenter: PaymentMachinesPresenterProtocol {
    
        func makeDataSource() {
        self.dataSource.removeAll()
        
        if getLocationNearByType == GetLocationsView.agentsView.rawValue {
            let howToAddMoneyTitleCell = HowToAddMoneyTableViewCellModel(titleLbl: Strings.AddMoney.howToAddMoney, subTitlelbl: Strings.AddMoney.simplyVisitAnyAuthorised)
            self.dataSource.append(howToAddMoneyTitleCell)
        }
        else{
            let paymentAcceptedTitleCell = GenericTitleAndImageTableViewCellModel(title: Strings.AddMoney.paymentAcceptedAtEtisalatStore, titleFontAndColor: (AppFont.appRegular(size: .body4), AppColor.eAnd_Black_80))
            self.dataSource.append(paymentAcceptedTitleCell)
            stepsGuidedCell()
        }
        view?.reloadData()
    }
    
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    private func stepsGuidedCell() {
        let stepsImageDataSource = [
            StepsToGuideCollectionViewCellModel(stepsImage: "StepsGuide_1", stepsSubTitle: Strings.AddMoney.findANearbyMachine),
            StepsToGuideCollectionViewCellModel(stepsImage: "StepsGuide_2", stepsSubTitle: Strings.AddMoney.enterYourMobileNumber),
            StepsToGuideCollectionViewCellModel(stepsImage: "StepsGuide_3", stepsSubTitle: Strings.AddMoney.insertCashIntoMachine)
            
        ]

        let exploreEAndMoney = StepsToGuideTableViewCellModel(actions: cellActions,
                                                                title: Strings.AddMoney.easyStepsToGuideYou,
                                                                dataSource: stepsImageDataSource,
                                                                itemSize: CGSize(width: 300, height: 280),
                                                                interItemSpacing: 0)
        dataSource.append(exploreEAndMoney)
    }
    
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
}

extension PaymentMachinesPresenter: PaymentMachinesInteractorOutputProtocol {}

// MARK: - Setup Cells Actions
extension PaymentMachinesPresenter {
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { [weak self] (index, model) in
            guard let `self` = self else { return }
            
        })
    }
}
