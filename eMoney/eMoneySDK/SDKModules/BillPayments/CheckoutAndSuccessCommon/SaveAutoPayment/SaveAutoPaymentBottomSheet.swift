//
//  SaveAutoPayment.swift
//  e&money
//
//  Created by Usama Zahid Khan on 21/06/2023.
//

import Foundation
import UIKit
enum OtherPaymentSource{
    case card
    case applepay
}
class SaveAutoPaymentBottomSheet {
    static let shared = SaveAutoPaymentBottomSheet()
    private init() {}
    private var cellActions:StandardCellActions? = nil
    private  var onSave:(()->Void)?
    private  var onSelecOther:((OtherPaymentSource)->Void)?
    func present(onSave:(()->Void)?) {
        self.setupCellAction()
        self.onSave = onSave
        var datasource:[StandardCellModel] = []
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.select_a_source,
                                                      font: AppFont.appRegular(size: .body2),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment: .center,
                                                      topSpace: 0,
                                                      leftSpace: 0,
                                                      rightSpace: 0,
                                                      bottomSpace: 0))
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.select_a_funding_method_in_case_your_e_money_account_has_insufficient,
                                                      font: AppFont.appRegular(size: .body3),
                                                      color: AppColor.eAnd_Grey_100,
                                                      alignment: .center,
                                                      topSpace: 20,
                                                      leftSpace: 44,
                                                      rightSpace: 44,
                                                      bottomSpace: 20))
        datasource.append(GenericSingleLabelCellModel(content: Strings.BillPayment.yourSavedCards,
                                                      font: AppFont.appSemiBold(size: .body2),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment: .left))
        datasource.append(TableViewCellModelWithUITableView(dataSource: self.getSavedCardsDatasource(),
                                                            borderWidth: 1,
                                                            borderColor: AppColor.eAnd_Grey_20,
                                                            cornerRadius: 12,
                                                            leftSpace: 24,
                                                            rightSpace: 24,
                                                            topSpace: 20,
                                                            bottomSpace: 20))
        datasource.append(SingleLineWithLabelTableViewCellModel(date:Strings.BillPayment.or,
                                                                dateColor: AppColor.eAnd_Grey_100))
        datasource.append(GenericSingleLabelCellModel(content: Strings.BillPayment.addADifferentSource,
                                                      font: AppFont.appSemiBold(size: .body2),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment: .left))
        datasource.append(OtherPaymentSourceCellModel(actions:cellActions,
                                                      leftImage: "other-source-card",
                                                      title:Strings.BillPayment.debit_credit_card,
                                                      rightImage: "arrow-right",
                                                      methodType: .card))
        datasource.append(SpaceTableViewCellModel(height: 20))
        datasource.append(SingleLineCellModel(lineColor: AppColor.eAnd_Grey_30,
                                              lineHeight: 1,
                                              leftSpace: 24,
                                              rightSpace: 24,
                                              topSpeace: 0,
                                              bottomSpace: 0))
        datasource.append(SpaceTableViewCellModel(height: 20))
        datasource.append(OtherPaymentSourceCellModel(actions:cellActions,
                                                      leftImage: "other-source-applepay",
                                                      title:Strings.BillPayment.apple_pay,
                                                      rightImage: "arrow-right",
                                                      methodType: .applepay))
        datasource.append(SpaceTableViewCellModel(height: 20))
        let saveButton = BaseButton()
        saveButton.setTitle(Strings.BillPayment.save_funding_method, for: .normal)
        saveButton.type = .GradientButton
        saveButton.titleLabel?.font = AppFont.appSemiBold(size: .body3)
        saveButton.titleLabel?.textColor = AppColor.eAnd_White
        saveButton.addTarget(self, action: #selector(saveFundingTapped), for: .touchUpInside)
        
        let input = GenericBottomSheetRouter.RouterInput(dataSource: datasource,actionButtons: [saveButton])
        let vc = GenericBottomSheetRouter.setupModule(input: input)
        vc.modalPresentationStyle = .fullScreen
        UIApplication.getTopViewController()?.present(vc, animated: true)
    }
    private func getSavedCardsDatasource() -> [StandardCellModel] {
        var datasource:[StandardCellModel] = []
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.cards,
                                                      font: AppFont.appRegular(size: .body3),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment: .left))
        datasource.append(SavedCardTableViewCellModel(leftImage: "visa-card",
                                                      title: "VISA card",
                                                      subtitle: "Debit card **** 1528"))
        datasource.append(SingleLineCellModel(lineColor: AppColor.eAnd_Grey_30,
                                              lineHeight: 1,
                                              leftSpace: 24,
                                              rightSpace: 24,
                                              topSpeace: 20,
                                              bottomSpace: 20))
        datasource.append(SavedCardTableViewCellModel(leftImage: "MasterCard", title: "Mastercard", subtitle: "Credit card **** 1511"))
        datasource.append(SpaceTableViewCellModel(height: 20))
        return datasource
    }
    private func setupCellAction() {
        self.cellActions = StandardCellActions{ index, model in
            if let model = model as? OtherPaymentSourceCellModel {
                self.onSelecOther?(model.methodType ?? .applepay)
            }
            if let model = model as? SavedCardTableViewCellModel {
                
            }
        }
    }
    @objc func saveFundingTapped(_ sender:UIButton) {
        UIApplication.getTopViewController()?.dismiss(animated: true)
        self.onSave?()
    }
}
