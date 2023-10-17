//
//  ActivateAutoRechargePrompt.swift
//  e&money
//
//  Created by Usama Zahid Khan on 21/06/2023.
//

import Foundation
import UIKit
class ActivateAutoRechargePrompt {
    static let shared = ActivateAutoRechargePrompt()
    private init() {}
    private var cellActions:StandardCellActions? = nil
    private  var onActive:(()->Void)?
    private  var onSelecOther:((OtherPaymentSource)->Void)?
    func present(onActive:(()->Void)?) {
        self.onActive = onActive
        var datasource:[StandardCellModel] = []
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.activate_auto_recharge,
                                                      font: AppFont.appRegular(size: .body2),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment: .center,
                                                      topSpace: 0,
                                                      leftSpace: 0,
                                                      rightSpace: 0,
                                                      bottomSpace: 0))
        datasource.append(TitleImageTableViewCellModel(titleImage: "other-source-applepay",
                                                       title: "43517253",
                                                       titleFont: AppFont.appSemiBold(size: .body2),
                                                       titleColor: AppColor.eAnd_Black_80))
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.we_will_notify_you_on_the_day_of_the_payment,
                                                      font: AppFont.appRegular(size: .body3),
                                                      color: AppColor.eAnd_Grey_100,
                                                      alignment: .center,
                                                      topSpace: 12,
                                                      leftSpace: 24,
                                                      rightSpace: 24,
                                                      bottomSpace: 12))
        datasource.append(SavedFundingMethodTableCellModel(title:Strings.BillPayment.saved_funding_methods,
                                                           subtitle: "VISA card **** 1511"))
        datasource.append(SpaceTableViewCellModel(height: 12))
        datasource.append(StandardTextFieldTableViewCellModel(actions: cellActions,
                                                              placeHolderText:Strings.BillPayment.recharging_amount,
                                                              leadingImage: nil,
                                                              trailingImage: nil,
                                                              methodType: nil))
        datasource.append(SpaceTableViewCellModel(height: 12))
        datasource.append(StandardTextFieldTableViewCellModel(actions: cellActions,
                                                              placeHolderText:Strings.BillPayment.auto_recharge_threshold,
                                                              leadingImage: nil,
                                                              trailingImage: "info-circle-bank",
                                                              methodType: nil))
        datasource.append(SpaceTableViewCellModel(height: 12))
        let saveButton = BaseButton()
        saveButton.setTitle(Strings.BillPayment.activate_auto_top_up, for: .normal)
        saveButton.type = .GradientButton
        saveButton.titleLabel?.font = AppFont.appSemiBold(size: .body3)
        saveButton.titleLabel?.textColor = AppColor.eAnd_White
        saveButton.addTarget(self, action: #selector(onActiveTapped), for: .touchUpInside)
        
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
        datasource.append(SavedCardTableViewCellModel(leftImage: "visa-card", title: "VISA card", subtitle: "Debit card **** 1528"))
        datasource.append(SingleLineCellModel(lineColor: AppColor.eAnd_Grey_30, lineHeight: 1, leftSpace: 24, rightSpace: 24, topSpeace: 0, bottomSpace: 0))
        datasource.append(SavedCardTableViewCellModel(leftImage: "MasterCard", title: "Mastercard", subtitle: "Credit card **** 1511"))
        return datasource
    }
    private func setupCellAction() {
        self.cellActions = StandardCellActions{ index, model in
            if let model = model as? OtherPaymentSourceCellModel {
                self.onSelecOther?(model.methodType ?? .applepay)
            }
        }
    }
    @objc func onActiveTapped(_ sender:UIButton) {
        UIApplication.getTopViewController()?.dismiss(animated: true)
        self.onActive?()
    }
}
