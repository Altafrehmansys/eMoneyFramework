//
//  DueBillsDetailPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/06/2023.
//  
//

import Foundation
import UIKit

class DueBillsDetailPresenter {

    // MARK: Properties

    weak var view: DueBillsDetailViewProtocol?
    var router: DueBillsDetailRouterProtocol?
    var interactor: DueBillsDetailInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var tableViewHeight: CGFloat = 0.0
    var isTopCellExpanded:Bool = false
    var isBottomCellExpanded:Bool = false
    var bottomCellSpace:CGFloat = 300
    var appliedPromo:String? = nil
    
}

extension DueBillsDetailPresenter: DueBillsDetailPresenterProtocol {
    func navigateToBillPaymentSuccess() {
        self.router?.go(to: .billPaymentSuccess)
    }
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
}

extension DueBillsDetailPresenter: DueBillsDetailInteractorOutputProtocol {
    
    
    func makeDataSource() {
        self.dataSource.removeAll()
        self.dataSource = self.setDataSource()
        view?.reloadData()
        
        if isBottomCellExpanded{
            bottomCellSpace = 300
        }else{
            bottomCellSpace = 120
        }
        
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
            
            if let _ = model as? DueBillsCollapsedTableViewCellModel  {
                self.isTopCellExpanded.toggle()
                self.makeDataSource()
            }
            if let _ = model as? MultiSelectedBillsTableViewCellModel  {
                self.isTopCellExpanded.toggle()
                self.makeDataSource()
            }
            
            
            if let _ = model as? CollapsableTitleTableViewCellModel  {
                self.isBottomCellExpanded.toggle()
                self.makeDataSource()
            }
            
            if let _ = model as? PromoCodeCellModel {
                if let promo = self.appliedPromo {
                    self.appliedPromo = nil
                    self.makeDataSource()
                }else{
                    self.presentAddPromo()
                }
            }
            if let promoTextFieldCellModel = model as? PromoTextFieldCellModel {
                UIApplication.getTopViewController()?.dismiss(animated: true,completion: {
                    self.appliedPromo = promoTextFieldCellModel.promo
                    self.makeDataSource()
                    self.showPromoApplied(promoTextFieldCellModel.promo ?? "")
                })
            }
            if let promoCellModel = model as? PromoCellModel {
                UIApplication.getTopViewController()?.dismiss(animated: true,completion: {
                    self.appliedPromo = promoCellModel.title
                    self.makeDataSource()
                    self.showPromoApplied(promoCellModel.title ?? "")
                })
            }
        }
    }
    
    private func setDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        
        if isTopCellExpanded{
        
            dataSource.append(MultiSelectedBillsTableViewCellModel(actions:self.cellActions,title: "Multiple bills", subTitle: "3 bills selected"))
            
            dataSource.append(ExpandedBillsTableViewCellModel(title: "Home electricity", subTitle: "Etihad water & electricity...", image: "etihad"))
            
            dataSource.append(ExpandedBillsTableViewCellModel(title: "1651216 6252123", subTitle: "DEWA", image: "etihad"))
            
            dataSource.append(ExpandedBillsTableViewCellModel(title: "Abdullah Mohammed", subTitle: "Etisalat prepaid", image: "etisalat"))
            
        }else{
            let cell1 = DueBillsCollapsedTableViewCellModel(actions: self.cellActions,title: "Multiple bills", subTitle: "3 bills selected", imageOne: "etisalat", imageTwo: "etihad", imageThree: "etisalat")
            dataSource.append(cell1)
        }
      
        dataSource.append(spaceCell(with: 54))
        
        dataSource.append(BillAmountTableViewCellModel(amount: "AED 706.00"))
        
        dataSource.append(spaceCell(with: bottomCellSpace))
        
        dataSource.append(TableViewCellModelWithUITableView(dataSource:expandedDataSource(), borderWidth:1, borderColor:AppColor.eAnd_Grey_30,cornerRadius: 16,leftSpace: 24,rightSpace: 24, bottomSpace: 20))
        
        calculateScreenSize()
       return dataSource
    }
    
    func calculateScreenSize(){
        let size = UIScreen.main.bounds.height
        print(size)
    }
    
    private func expandedDataSource() -> [StandardCellModel] {
        
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        
        if isBottomCellExpanded {
            
            dataSource.append(CollapsableTitleTableViewCellModel(actions:self.cellActions,title: "Payment details", isCollapsed:false))
            dataSource.append(KeyValueTableViewCellModel(key: "Etihad water & electricity", value: "AED 280.00"))
            dataSource.append(KeyValueTableViewCellModel(key: "Merchant fees", value: "AED 5.00"))
            dataSource.append(dividerCell())
            dataSource.append(KeyValueTableViewCellModel(key: "Etihad water & electricity", value: "AED 280.00"))
            dataSource.append(KeyValueTableViewCellModel(key: "Merchant fees", value: "AED 5.00"))
            dataSource.append(dividerCell())
            dataSource.append(KeyValueTableViewCellModel(key: "Etihad water & electricity", value: "AED 280.00"))
            dataSource.append(KeyValueTableViewCellModel(key: "Merchant fees", value: "AED 5.00"))
            dataSource.append(dividerCell())
            dataSource.append(KeyValueTableViewCellModel(key: "Fee", value: "FREE"))
            if let promo = appliedPromo {
                dataSource.append(PromoCodeCellModel(actions:cellActions,
                                                     parentColor: AppColor.eAnd_Main_USP,
                                                     leftImage: UIImage(named: "tag-promo-applied"),
                                                     promoLabel: "Saved AED 5.00 with \(promo)",
                                                     isPromoApplied: true))
            }else{
                dataSource.append(PromoCodeCellModel(actions:cellActions,
                                                     parentColor: AppColor.eAnd_Best_seller_light,
                                                     leftImage: UIImage(named: "tag-icon"),
                                                     promoLabel: "Have a promo code?"))
            }
            dataSource.append(KeyValueTableViewCellModel(key: "Total Payment", value: "AED 721.00"))
            dataSource.append(spaceCell(with: 20))
            
        }else{
            dataSource.append(CollapsableTitleTableViewCellModel(actions:self.cellActions,title: "Payment details", isCollapsed:true))
            dataSource.append(KeyValueTableViewCellModel(key: "Total Payment", value: "AED 721.00"))
            if let promo = appliedPromo {
                dataSource.append(PromoCodeCellModel(actions:cellActions,
                                                     parentColor: AppColor.eAnd_Main_USP,
                                                     leftImage: UIImage(named: "tag-promo-applied"),
                                                     promoLabel: "Saved AED 5.00 with \(promo)",
                                                     isPromoApplied: true))
            }else{
                dataSource.append(PromoCodeCellModel(actions:cellActions,
                                                     parentColor: AppColor.eAnd_Best_seller_light,
                                                     leftImage: UIImage(named: "tag-icon"),
                                                     promoLabel: "Have a promo code?"))
            }
            dataSource.append(spaceCell(with: 20))
            
        }
        return dataSource
        
    }
    private func presentPromoSelection() {
        var datasource: [StandardCellModel] = []
        datasource.append(SpaceTableViewCellModel(height: 24))
        datasource.append(PromoTextFieldCellModel(actions: self.cellActions))
        datasource.append(SpaceTableViewCellModel(height: 24))
        datasource.append(PromoCellModel(actions: self.cellActions,
                                         backgroundColor: AppColor.eAnd_Main_USP,
                                         title: "UAEDAY",
                                         subTitle: "Get a discount on your first bill payment via e& money up to AED 10.00"))
        datasource.append(SpaceTableViewCellModel(height: 24))
        datasource.append(PromoCellModel(actions: self.cellActions,
                                         backgroundColor: AppColor.eAnd_Online_Exclusive,
                                         title: "GET15",
                                         subTitle: "Get 15% discount on paying up to 7 bills together using multiple bill feature."))
        datasource.append(SpaceTableViewCellModel(height: 24))
        datasource.append(PromoCellModel(actions: self.cellActions,
                                         backgroundColor: AppColor.eAnd_Error_10,
                                         title: "GOZERO",
                                         subTitle: "We’ll waiver transaction fees for 1 bill payment. Valid for February 2023 only."))
        datasource.append(SpaceTableViewCellModel(height: 24))
        self.router?.go(to: .addPromo(input: GenericBottomSheetRouter.RouterInput(dataSource: datasource)))
    }
    private func showPromoApplied(_ promo: String) {
        var datasource: [StandardCellModel] = []
        datasource.append(SingleImageTableViewCellModel(image: "promo-bell"))
        datasource.append(GenericSingleLabelCellModel(content: "Code \(promo) applied.".localized,
                                                      font: AppFont.appSemiBold(size: .h7),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment:.center))
        datasource.append(GenericSingleLabelCellModel(content: "Congratulations!".localized,
                                                      font: AppFont.appLight(size: .h7),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment:.center))
        datasource.append(SpaceTableViewCellModel(height: 48))
        router?.go(to: .showPromoApplied(input: GenericBottomSheetRouter.RouterInput(dataSource:datasource)))
    }
    func presentAddPromo() {
        self.presentPromoSelection()
    }
    
}
