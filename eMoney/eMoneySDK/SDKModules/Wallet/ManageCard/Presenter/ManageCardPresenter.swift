//
//  ManageCardPresenter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/07/2023.
//  
//

import Foundation
import UIKit

class ManageCardPresenter {
    
    // MARK: Properties
    
    weak var view: ManageCardViewProtocol?
    var router: ManageCardRouterProtocol?
    var interactor: ManageCardInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    class MethodType: MethodOptionsBaseTypes {
        enum CellType {
            case applePay
            case cardColor
            case autoAddMoney
            case changeCardPIN
            case freezCard
            case cardAccountLimits
            case cancelCard
            case reportLostCard
            case general
        }
        var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
        }
    }
    
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    func makeDatasource() {
        var cells:[StandardCellModel] = []
        cells.append(GenericSingleLabelCellModel(content: Strings.Wallet.apple_pay,
                                                 font: AppFont.appSemiBold(size: .body2),
                                                 color: AppColor.eAnd_Black_80,
                                                 alignment: .left))
        cells.append(SpaceTableViewCellModel(height: 16))
        let applePayCell = GenericLabelWithLeftRightImageCellModel(actions: self.cellActions,
                                                                   methodType: MethodType(type: .applePay),
                                                                   leftImage: nil,
                                                                   title: Strings.Wallet.add_to_applewallet,
                                                                   titleFont: AppFont.appRegular(size: .body4),
                                                                   titleColor: AppColor.eAnd_Black_80,
                                                                   rightImage: "add-apple-wallet",
                                                                   rightImageSize: CGSize(width: 100, height: 32))
        cells.append(TableViewCellModelWithUITableView(actions: self.cellActions,
                                                       dataSource: [applePayCell],
                                                       borderWidth: 1,
                                                       borderColor: AppColor.eAnd_Grey_20,
                                                       cornerRadius: 12,
                                                       leftSpace: 20,
                                                       rightSpace: 20,
                                                       topSpace: 20,
                                                       bottomSpace: 20))
        cells.append(SpaceTableViewCellModel(height: 20))
        cells.append(GenericSingleLabelCellModel(content: Strings.Wallet.customise_card_face,
                                                 font: AppFont.appSemiBold(size: .body2),
                                                 color: AppColor.eAnd_Black_80,
                                                 alignment: .left))
        let selectCardColorCell = GenericLabelWithLeftRightImageCellModel(actions: self.cellActions,
                                                                          methodType: MethodType(type: .cardColor),
                                                                          leftImage: "card-bg",
                                                                          leftImageSize: CGSize(width: 50, height: 31.5),
                                                                          title: "\(Strings.Wallet.selected_color) \(Strings.Wallet.red)",
                                                                          titleFont: AppFont.appRegular(size: .body3),
                                                                          titleColor: AppColor.eAnd_Black_80)
        cells.append(TableViewCellModelWithUITableView(actions: self.cellActions,
                                                       dataSource: [selectCardColorCell],
                                                       borderWidth: 1,
                                                       borderColor: AppColor.eAnd_Grey_20,
                                                       cornerRadius: 12,
                                                       leftSpace: 20,
                                                       rightSpace: 20,
                                                       topSpace: 20,
                                                       bottomSpace: 20))
        cells.append(SpaceTableViewCellModel(height: 20))
        cells.append(GenericSingleLabelCellModel(content: Strings.Wallet.manage_card,
                                                 font: AppFont.appSemiBold(size: .body2),
                                                 color: AppColor.eAnd_Black_80,
                                                 alignment: .left))
        cells.append(SpaceTableViewCellModel(height: 4))
        
        let manageCardCells:[StandardCellModel] = [
            AutoAddMoneyCellModel(actions: self.cellActions,title: "Auto add money",methodType: MethodType(type:.autoAddMoney)),
            SingleLineCellModel(lineColor: AppColor.eAnd_Grey_20,lineHeight: 1,leftSpace: 20,rightSpace: 20),
            labelWithLeftRightImageCell(title: "\(Strings.Wallet.change_card_pin) \(Strings.Wallet.red)",titleFont: AppFont.appRegular(size: .body4), methodType: MethodType(type: .changeCardPIN)),
            SingleLineCellModel(lineColor: AppColor.eAnd_Grey_20,lineHeight: 1,leftSpace: 20,rightSpace: 20),
            labelWithLeftRightImageCell(title: "\(Strings.Wallet.freeze_card) \(Strings.Wallet.red)",titleFont: AppFont.appRegular(size: .body4), methodType: MethodType(type: .freezCard)),
            SingleLineCellModel(lineColor: AppColor.eAnd_Grey_20,lineHeight: 1,leftSpace: 20,rightSpace: 20),
            labelWithLeftRightImageCell(title: "Account Limits",titleFont: AppFont.appRegular(size: .body4), methodType: MethodType(type: .cardAccountLimits)),
            SingleLineCellModel(lineColor: AppColor.eAnd_Grey_20,lineHeight: 1,leftSpace: 20,rightSpace: 20),
            labelWithLeftRightImageCell(title: "\(Strings.Wallet.cancel_card) \(Strings.Wallet.red)",titleFont: AppFont.appRegular(size: .body4), methodType: MethodType(type: .cancelCard)),
            SingleLineCellModel(lineColor: AppColor.eAnd_Grey_20,lineHeight: 1,leftSpace: 20,rightSpace: 20),
            labelWithLeftRightImageCell(title: "\(Strings.Wallet.report_lost_card) \(Strings.Wallet.red)",titleFont: AppFont.appRegular(size: .body4), methodType: MethodType(type: .reportLostCard))
        ]
        cells.append(TableViewCellModelWithUITableView(actions: self.cellActions,
                                                       dataSource: manageCardCells,
                                                       borderWidth: 1,
                                                       borderColor: AppColor.eAnd_Grey_20,
                                                       cornerRadius: 12,
                                                       leftSpace: 20,
                                                       rightSpace: 20,
                                                       topSpace: 20,
                                                       bottomSpace: 20))
        cells.append(OrderPhysicalCardCellModel(actions:self.cellActions))
        
        
        self.dataSource = cells
    }
    func labelWithLeftRightImageCell(leftImage: String? = nil,
                                title: String,
                                titleFont: UIFont = AppFont.appRegular(size: .body3),
                                     titleColor: UIColor = AppColor.eAnd_Black_80,methodType:MethodType) -> GenericLabelWithLeftRightImageCellModel {
        return GenericLabelWithLeftRightImageCellModel(actions: self.cellActions,
                                                       methodType: methodType,
                                                       leftImage: leftImage,
                                                       title:title,
                                                       titleFont: AppFont.appRegular(size: .body3),
                                                       titleColor: AppColor.eAnd_Black_80)
        
    }
    private func setupTableViewCellActions() {
        self.cellActions = StandardCellActions{ index, model in
            if let model = model as? GenericLabelWithLeftRightImageCellModel, let methodType = model.methodType as? MethodType {
                switch methodType.type {
                case .changeCardPIN:
                    self.navigateToChangeCardPIN()
                case .reportLostCard:
                    self.navigateToReportLostCard()
                case .cancelCard:
                    self.loadCancelCardBottomsheet()
                case .cardAccountLimits:
                    self.navigateToCarsAccountLimits()
                case .freezCard:
                    self.loadFreezCardBottomSheet()
              
                default:
                    break
                }
            }
            if let model = model as? AutoAddMoneyCellModel, let methodType = model.methodType as? MethodType {
                switch methodType.type {
                case .autoAddMoney:
                    self.loadAddAutoMoneyBottomSheet()
                default:
                    break
                }
            }
            
            if let _ = model as? OrderPhysicalCardCellModel  {
                self.navigateToOrderCard()
            }
        }
    }
}

extension ManageCardPresenter: ManageCardPresenterProtocol {
    
    func loadData() {
        self.view?.setupUI()
        self.setupTableViewCellActions()
        self.makeDatasource()
        self.view?.reloadTableView()
    }
    
    func navigateToOrderCard() {
        self.router?.go(to: .orderCard)
    }
    func navigateToChangeCardPIN() {
        self.router?.go(to: .changeCardPIN)
    }
    func navigateToReportLostCard() {
        self.router?.go(to: .reportLostCard)
    }
    func loadCancelCardBottomsheet() {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(GenericSingleLabelCellModel(content:"Cancel card",font: AppFont.appRegular(size: .body2),color: AppColor.eAnd_Black_80,alignment: .center))
        dataSource.append(GenericSingleLabelCellModel(content: "You can only cancel your e& money card 3 times. You have 2 cancellations left.",font: AppFont.appRegular(size: .body4),color: AppColor.eAnd_Grey_100,alignment:.center))
       
        dataSource.append(CancelCardReasonsCellModel(placeHolderText: "Select a reason",dropDownDataSource:["I have unrecognised transactions","I have better prepaid card options","I don’t use the card","My card is lost/stolen","Other reasons"], errorText: ""))
        dataSource.append(TellUsMoreCellModel(placeHolderText: "Tell us more"))
        
        let cancelCardButton = BaseButton()
        cancelCardButton.type = .GradientButton
        cancelCardButton.setTitle("Cancel card", for: .normal)
        cancelCardButton.addTarget(self, action: #selector(cancelCardButtonTappedAction), for: .touchUpInside)
        self.router?.go(to:.cancelCardBottomSheet(dataSource: dataSource, actions: [cancelCardButton]))
    }
    
    func navigateToCancelCard() {
        self.router?.go(to: .navigateToCancelCard)
    }
    
    func navigateToCarsAccountLimits() {
        self.router?.go(to: .navigateToCarsAccountLimits)
    }
    
    func loadFreezCardBottomSheet() {
        var dataSource = [StandardCellModel]()
        let titleCellModel = TitleImageTableViewCellModel(titleImage: "freez-icon", title:"Freeze card", titleFont: AppFont.appSemiBold(size: .h7), titleColor: AppColor.eAnd_Black_80)
        dataSource.append(titleCellModel)
        dataSource.append(GenericSingleLabelCellModel(content: "Confirm if you would like to temporarily freeze your card.", font: AppFont.appRegular(size: .body4), color: AppColor.eAnd_Grey_100, alignment: .center))
        let freezButton = BaseButton()
        freezButton.type = .GradientButton
        freezButton.setTitle("Freez", for: .normal)
        freezButton.addTarget(self, action: #selector(freezButtonAction), for: .touchUpInside)
        let cancelButton = BaseButton()
        cancelButton.type = .PlainButton
        cancelButton.setTitle(Strings.Generic.cancel, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        self.router?.go(to: .loadFreezCardBottomSheet(dataSource: dataSource, actions: [freezButton, cancelButton]))
    }
    func loadAddAutoMoneyBottomSheet() {
        
        var dataSource = [StandardCellModel]()
      
        dataSource.append(GenericSingleLabelCellModel(content: "Activate auto add money", font: AppFont.appRegular(size: .body2), color: AppColor.eAnd_Black_80, alignment: .center))
        dataSource.append(GenericSingleLabelCellModel(content: "Select an auto funding method for your e& money account", font: AppFont.appRegular(size: .body3), color: AppColor.eAnd_Grey_100, alignment: .center))
        dataSource.append(GenericSingleLabelCellModel(content: "Your saved cards", font: AppFont.appSemiBold(size: .body2), color: AppColor.eAnd_Black_80))
        
        var childDataSource = [StandardCellModel]()
        childDataSource.append(GenericSingleLabelCellModel(content: "Card", font: AppFont.appRegular(size: .body3), color: AppColor.eAnd_Black_80))
        childDataSource.append(SpaceTableViewCellModel(height: 20))
        childDataSource.append(SavedCardsCellModel(isSelectedCard: true, cardImage: "visa-card-icon", cardType: "VISA card", cardNumber: "Debit card **** 1528"))
        childDataSource.append(dividerCell())
        childDataSource.append(SavedCardsCellModel(isSelectedCard: false, cardImage: "visa-card-icon", cardType: "Mastercard", cardNumber: "Debit card **** 1528"))
        childDataSource.append(SpaceTableViewCellModel(height: 20))
        dataSource.append(TableViewCellModelWithUITableView(dataSource: childDataSource,
                                                             borderWidth: 1,
                                                             borderColor: AppColor.eAnd_Grey_30,
                                                             cornerRadius: 10,
                                                             leftSpace: 24,
                                                             rightSpace: 24))
        dataSource.append(SpaceTableViewCellModel(height: 20))
        dataSource.append(SeparatorWithTextCellModel(text: "OR"))
        dataSource.append(GenericSingleLabelCellModel(content: "Add a different source", font: AppFont.appSemiBold(size: .body2), color: AppColor.eAnd_Black_80))
        dataSource.append(SavedAccountCellModel(actions: self.cellActions,cardImage: "debit-card", account: "Debit / credit card", cardNumber: "100% secure transfers"))
        dataSource.append(SavedAccountCellModel(actions: self.cellActions,cardImage: "other-source-applepay", account: "Apple Pay", cardNumber: "Quick and convenient"))
        
        let saveButton = BaseButton()
        saveButton.type = .GradientButton
        saveButton.setTitle("Save method", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)

        self.router?.go(to: .loadAddAutoMoneyBottomSheet(dataSource: dataSource, actions: [saveButton]))
    }
    @objc private func saveButtonAction() {
        
    }
    
    @objc private func freezButtonAction() {
        
    }
    @objc private func cancelAction() {
        
    }
    @objc private func cancelCardButtonTappedAction() {
        self.navigateToCancelCard()
    }
}

extension ManageCardPresenter: ManageCardInteractorOutputProtocol {
    
}
