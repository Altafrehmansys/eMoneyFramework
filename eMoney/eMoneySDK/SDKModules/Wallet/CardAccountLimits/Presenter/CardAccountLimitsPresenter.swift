//
//  CardAccountLimitsPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/07/2023.
//  
//

import Foundation

class CardAccountLimitsPresenter {

    // MARK: Properties

    weak var view: CardAccountLimitsViewProtocol?
    var router: CardAccountLimitsRouterProtocol?
    var interactor: CardAccountLimitsInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    class MethodType: MethodOptionsBaseTypes {
        enum CellType {
            case onlineTransations
            case atmWithdrwals
            case merchantoutlets
            case contactLessPayments
            case overseasSpend
            case general
        }
        var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
        }
    }
    
}

extension CardAccountLimitsPresenter: CardAccountLimitsPresenterProtocol {
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
    
    func makeDataSource() {
        self.dataSource.removeAll()
        self.dataSource = self.setDataSource()
        view?.reloadData()
    }

    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    private func spaceCell(with space: CGFloat) -> SpaceTableViewCellModel {
        let cellModel = SpaceTableViewCellModel(height: space)
        return cellModel
    }
    
    private func setupCellActions() {
        cellActions = StandardCellActions{ index, model in
//            if let model = model as? SavedAccountCellModel, let methodType = model.methodType as? MethodType {
//                switch methodType.type {
//                case .bank:
//                    self.loadBankBottomSheetView()
//                case .card:
//                    self.loadCardBottomSheetView()
//                default:
//                    break
//                }
//            }
        }
    }
    
    private func setDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(CardAccountLimitCellModel(title: "Online transations", subTitle: "Allow online transations with e&money card", placeHolderText: "", minLimit: "100", maxLimit: "5000"))
        dataSource.append(dividerCell())
        dataSource.append(CardAccountLimitCellModel(title: "Online transations", subTitle: "Allow online transations with e&money card", placeHolderText: "", minLimit: "100", maxLimit: "5000"))
        dataSource.append(dividerCell())
        dataSource.append(CardAccountLimitCellModel(title: "Online transations", subTitle: "Allow online transations with e&money card", placeHolderText: "", minLimit: "100", maxLimit: "5000"))
        dataSource.append(dividerCell())
        dataSource.append(CardAccountLimitCellModel(title: "Online transations", subTitle: "Allow online transations with e&money card", placeHolderText: "", minLimit: "100", maxLimit: "5000"))
        dataSource.append(dividerCell())
        dataSource.append(CardAccountLimitCellModel(title: "Online transations", subTitle: "Allow online transations with e&money card", placeHolderText: "", minLimit: "100", maxLimit: "5000"))
        return dataSource
    }
    

}

extension CardAccountLimitsPresenter: CardAccountLimitsInteractorOutputProtocol {
    
}
