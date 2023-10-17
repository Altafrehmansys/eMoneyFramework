//
//  WalletCheckoutPresenter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import Foundation
import UIKit

class WalletCheckoutPresenter {
    
    // MARK: Properties
    
    weak var view: WalletCheckoutViewProtocol?
    var router: WalletCheckoutRouterProtocol?
    var interactor: WalletCheckoutInteractorProtocol?
    var datasource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var appliedPromo:String? = nil
    var billInput: BillAccountDetailsParameters? = nil
    
    var isCollapsed:Bool = true  {
        didSet {
            DispatchQueue.main.async {
                self.setupDatasource()
                self.view?.reloadTableView()
            }
        }
    }
    fileprivate func setupDatasource() {
        self.datasource = self.getPaymentDetailsDatasource()
        view?.reloadTableView()
    }
    private func getPaymentDetailsDatasource() -> [StandardCellModel] {
        var dataSource:[StandardCellModel] = []
        dataSource.append(SpaceTableViewCellModel(height: 15))
        dataSource.append(CollapsableTitleTableViewCellModel(actions:self.cellActions,title:Strings.BillPayment.paymentDetails, isCollapsed:isCollapsed))
        if self.isCollapsed {
            if let promo = appliedPromo {
                dataSource.append(PromoCodeCellModel(actions:cellActions,
                                                     parentColor: AppColor.eAnd_Main_USP,
                                                     leftImage: UIImage(named: "tag-promo-applied"),
                                                     promoLabel: "\(Strings.BillPayment.saved) AED 5.00 with \(promo)",
                                                     isPromoApplied: true))
            }else{
                dataSource.append(PromoCodeCellModel(actions:cellActions,
                                                     parentColor: AppColor.eAnd_Best_seller_light,
                                                     leftImage: UIImage(named: "tag-icon"),
                                                     promoLabel:Strings.BillPayment.haveAPromoCode))
            }
            dataSource.append(SpaceTableViewCellModel(height:10))
            dataSource.append(SingleLineCellModel(leftSpace:24,rightSpace: 24))
            dataSource.append(SpaceTableViewCellModel(height:10))
            dataSource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.totalPayment, value: billInput?.billDueAmount ?? ""))
            dataSource.append(SpaceTableViewCellModel(height:10))
        }else{
            dataSource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.rechargeAmount, value: billInput?.billDueAmount ?? ""))
            dataSource.append(SpaceTableViewCellModel(height:10))
            dataSource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.merchantFees, value: "AED 0.00"))
            dataSource.append(SpaceTableViewCellModel(height:10))
            dataSource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.e_money_transaction_fee, value:Strings.BillPayment.free))
            dataSource.append(SpaceTableViewCellModel(height:10))
            if let promo = appliedPromo {
                dataSource.append(PromoCodeCellModel(actions:cellActions,
                                                     parentColor: AppColor.eAnd_Main_USP,
                                                     leftImage: UIImage(named: "tag-promo-applied"),
                                                     promoLabel: "\(Strings.BillPayment.saved) AED 5.00 with \(promo)",
                                                     isPromoApplied: true))
            }else{
                dataSource.append(PromoCodeCellModel(actions:cellActions,
                                                     parentColor: AppColor.eAnd_Best_seller_light,
                                                     leftImage: UIImage(named: "tag-icon"),
                                                     promoLabel:Strings.BillPayment.haveAPromoCode))
            }
            dataSource.append(SpaceTableViewCellModel(height:10))
            dataSource.append(SingleLineCellModel(leftSpace:24,rightSpace: 24))
            dataSource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.totalPayment, value: billInput?.billDueAmount ?? ""))
            dataSource.append(SpaceTableViewCellModel(height:10))
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
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { index, model in
            if let _ = model as? CollapsableTitleTableViewCellModel {
                self.isCollapsed.toggle()
                self.setupDatasource()
            }
            if let _ = model as? PromoCodeCellModel {
                if let promo = self.appliedPromo {
                    self.appliedPromo = nil
                    self.setupDatasource()
                }else{
                    self.presentAddPromo()
                }
            }
            if let promoTextFieldCellModel = model as? PromoTextFieldCellModel {
                UIApplication.getTopViewController()?.dismiss(animated: true,completion: {
                    self.appliedPromo = promoTextFieldCellModel.promo
                    self.setupDatasource()
                    self.showPromoApplied(promoTextFieldCellModel.promo ?? "")
                })
            }
            if let promoCellModel = model as? PromoCellModel {
                UIApplication.getTopViewController()?.dismiss(animated: true,completion: {
                    self.appliedPromo = promoCellModel.title
                    self.setupDatasource()
                    self.showPromoApplied(promoCellModel.title ?? "")
                })
            }
        })
    }
}

extension WalletCheckoutPresenter: WalletCheckoutPresenterProtocol {
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.setupDatasource()
        self.view?.updatePayBtn(fees: billInput?.billDueAmount ?? "")
    }
    func navigateToSuccess() {
//        let data = WalletCheckoutRequest(accountNumber: billInput?.accountNumber, accountTitle: "Title", amount: billInput?.enterBillAmount?.filter("0123456789.".contains), amountDue: billInput?.billDueAmount?.filter("0123456789.".contains), pin: billInput?.pin, providerPin: nil, providerTransaction: nil, serviceId: billInput?.selectedItem?.serviceId, msisdn: GlobalData.shared.msisdn, senderMsisdn: GlobalData.shared.msisdn, transactionId: billInput?.transactionId)
//        if billInput?.billType == .ipMobile ||  billInput?.billType == .vehicleSalik {
//            interactor?.submitPaymentiInternational(data: data)
//            return 
//        }
//        interactor?.submitPayment(data: data)
        //
        router?.go(to: .requestCardSuccess)
    }
    func presentAddPromo() {
        self.presentPromoSelection()
    }
}

extension WalletCheckoutPresenter: WalletCheckoutInteractorOutputProtocol {
    func didSuccessSubmitPayment(data: WalletCheckoutResponseModel) {

    }
    func didSuccessSubmitInternationalPayment(data: WalletCheckoutResponseModel) {

    }
    func didFailedSubmitPayment(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.error, message: error.errorDescription)
    }
}
