//
//  CardDetailsPresenter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 10/07/2023.
//  
//

import Foundation

class CardDetailsPresenter {

    // MARK: Properties

    weak var view: CardDetailsViewProtocol?
    var router: CardDetailsRouterProtocol?
    var interactor: CardDetailsInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    func makeDatasource() {
        var cells:[StandardCellModel] = []
        cells.append(GenericSingleLabelCellModel(content: Strings.Wallet.account_balance,
                                                font: AppFont.appLight(size: .body2),
                                                color: AppColor.eAnd_Black_80,
                                                alignment: .center))
        cells.append(GenericAmountCellModel(amount: "840", isEnabled: true))
        cells.append(SpaceTableViewCellModel(height: 27))
        cells.append(CardCellModel(cardBGImage: "card-bg",
                                   cardBrandImage:"e&money-logo",
                                   cardNo: "1234 5678 9012 3456",
                                   allowCopyCardNo: true,
                                   cardExpiry: "12/24",
                                   cardCVV: "234",
                                   cardTitle: "ABDULLA MOHAMMED ANSA",
                                   allowCopyCardTitle: true,
                                   cardTypeImage: "MasterCard"))
        cells.append(SpaceTableViewCellModel(height: 20))
//        let collectionCells:[StandardCellModel] = [SavedBillCellModel(title: Strings.Wallet.add_money,
//                                                                      imgName: "add-money"),
//                                                   SavedBillCellModel(title: Strings.Wallet.card_details,
//                                                                      imgName: "card-details"),
//                                                   SavedBillCellModel(title: Strings.Wallet.manage_card,
//                                                                      imgName: "manage-card"),
//                                                   SavedBillCellModel(title: Strings.Wallet.spend_analysis,
//                                                                      imgName: "spend-analysis")]
        /*cells.append(HorizontalCollectionTableViewCellModel(actions: self.cellActions, datasource: collectionCells, cellSize: CGSize(width: 75, height: 80), spacing: 0, collectionHeight: 75))*/
        cells.append(GenericTitleAndButtonTableViewCellModel(actions: self.cellActions, title: "\(Strings.Wallet.transaction_history) (AED)" , buttonTitle: Strings.BillPayment.viewAll))
        cells.append(SpaceTableViewCellModel(height: 32))
        cells.append(TransactionHistoryCellModel(actions: self.cellActions,
                                                 leftImage: "etisalat",
                                                 title: "Aish ****98274",
                                                 subtitle: "Etisalat postpaid",
                                                 date: "Yesterday",
                                                 amount: "- 90.00",
                                                 points: "0.90"))
//        cells.append(SingleLineCellModel(lineColor: AppColor.eAnd_Grey_30,
//                                         leftSpace: 24,
//                                         rightSpace: 24,
//                                         topSpeace: 20,
//                                         bottomSpace: 20))
        cells.append(TransactionHistoryCellModel(actions: self.cellActions,
                                                 leftImage: "etisalat",
                                                 title: "Aish ****98274",
                                                 subtitle: "Etisalat postpaid",
                                                 date: "Yesterday",
                                                 amount: "- 90.00",
                                                 points: "0.90"))
//        cells.append(SingleLineCellModel(lineColor: AppColor.eAnd_Grey_30,
//                                         leftSpace: 24,
//                                         rightSpace: 24,
//                                         topSpeace: 20,
//                                         bottomSpace: 20))
        cells.append(TransactionHistoryCellModel(actions: self.cellActions,
                                                 leftImage: "etisalat",
                                                 title: "Aish ****98274",
                                                 subtitle: "Etisalat postpaid",
                                                 date: "Yesterday",
                                                 amount: "- 90.00",
                                                 points: "0.90"))
//        cells.append(SingleLineCellModel(lineColor: AppColor.eAnd_Grey_30,
//                                         leftSpace: 24,
//                                         rightSpace: 24,
//                                         topSpeace: 20,
//                                         bottomSpace: 20))
                     
        self.dataSource = cells
    }
    private func setupTableViewCellActions() {
        self.cellActions = StandardCellActions{ index, model in
            if let cell = model as? HorizontalCollectionTableViewCellModel {
                switch index {
                case 0:
                    print("Navigate to add money")
                case 1:
                    print("Show card details")
                case 2:
                    print("Navigate to manage cards")
                    self.navigateToManageCard()
                case 3:
                    print("Navigate to spend analysis")
                default:break
                }
            }
        }
    }
}

extension CardDetailsPresenter: CardDetailsPresenterProtocol {
    func navigateToManageCard() {
        self.router?.go(to: .manageCards)
    }
    
    
    func loadData() {
        self.view?.setupUI()
        self.setupTableViewCellActions()
        self.makeDatasource()
        self.view?.reloadTableView()
    }
}

extension CardDetailsPresenter: CardDetailsInteractorOutputProtocol {
    
}
