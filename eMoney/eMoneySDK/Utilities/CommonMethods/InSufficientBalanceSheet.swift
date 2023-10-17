//
//  InSufficientBalanceSheet.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/07/2023.
//

import Foundation

import Foundation
import UIKit
class InSufficientBalanceSheet {
    static let shared = InSufficientBalanceSheet()
    private  var cellActions: StandardCellActions? = nil
    private var isSavedCards:Bool = false
    private func spaceCell(with space: CGFloat) -> SpaceTableViewCellModel {
        let cellModel = SpaceTableViewCellModel(height: space)
        return cellModel
    }
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    
    func presentInSufficientBottomSheet(amountTobeDetected:Float) {
        
        self.setupCellActions()
        var dataSource:[StandardCellModel] = []
        dataSource.append(GenericSingleLabelCellModel(content:Strings.Generic.insufficient_balance,
                                                      font: AppFont.appRegular(size: .body2),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment:.center))
        dataSource.append(GenericSingleLabelCellModel(content:Strings.Generic.select_source_to_add_remaining_amount,
                                                      font: AppFont.appRegular(size: .body4),
                                                      color: AppColor.eAnd_Grey_100,
                                                      alignment:.center))
        dataSource.append(spaceCell(with: 20))
        dataSource.append(TableViewCellModelWithUITableView(dataSource:isSavedCards ? savedPaymentSource():notSavedPaymentSource(), borderWidth: 1,
                                                            borderColor: AppColor.eAnd_Grey_30,
                                                            cornerRadius: 10,
                                                            leftSpace: 24,
                                                            rightSpace: 24))
        dataSource.append(spaceCell(with: 20))
        dataSource.append(GenericSingleLabelCellModel(content:Strings.Generic.payment_source,
                                                                        font: AppFont.appRegular(size: .body3),
                                                                        color: AppColor.eAnd_Black_80,
                                                                        alignment:.left))
        dataSource.append(spaceCell(with: 20))
        
        dataSource.append(TableViewCellModelWithUITableView(dataSource:[KeyValueTableViewCellModel(key:Strings.Generic.wallet_balance, value: "AED 20.0",topSpace: 20,bottomSpace: 10),KeyValueTableViewCellModel(key:Strings.Generic.balance_to_be_added, value: "AED 6.25",topSpace: 10,bottomSpace: 10),dividerCell(),
            KeyValueTableViewCellModel(key: Strings.Generic.total_to_be_deducted, value: "AED 26.25",topSpace: 10,bottomSpace: 20)], borderWidth: 1,
                                                            borderColor: AppColor.eAnd_Grey_30,
                                                            cornerRadius: 10,
                                                            leftSpace: 24,
                                                            rightSpace: 24,bottomSpace: 31))
        
        let confirmButton = BaseButton()
        confirmButton.type = .GradientButton
        confirmButton.setTitle(Strings.Generic.confirm_btn_text, for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource,actionButtons:[confirmButton])
        let vc = GenericBottomSheetRouter.setupModule(input: input)
        vc.modalPresentationStyle = .overCurrentContext
        UIApplication.getTopViewController()?.present(vc, animated: true)
    }
    
    
    func presentAllPaymentMethodsBottomSheet(amountTobeDetected:Float){
        
        self.setupCellActions()
        var dataSource:[StandardCellModel] = []
        dataSource.append(GenericSingleLabelCellModel(content:Strings.Generic.insufficient_balance,
                                                      font: AppFont.appRegular(size: .body2),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment:.center))
        dataSource.append(GenericSingleLabelCellModel(content:Strings.Generic.select_source_to_add_remaining_amount,
                                                      font: AppFont.appRegular(size: .body4),
                                                      color: AppColor.eAnd_Grey_100,
                                                      alignment:.center))
        dataSource.append(GenericAmountCellModel(amount:"AED 6.25",isEnabled: false))
        dataSource.append(AddNewMethodCellModel(actions: self.cellActions,image:"other-source-applepay", title: "Apple Pay"))
        dataSource.append(dividerCell())
        dataSource.append(AddNewMethodCellModel(actions: self.cellActions,image:"etisalat", title: "Cash advance"))
        dataSource.append(dividerCell())
        dataSource.append(SavedAccountCellModel(actions: self.cellActions,cardImage: "visa-card-icon", account: "VISA card", cardNumber:"Debit card **** 1528"))
        dataSource.append(dividerCell())
        dataSource.append(AddNewMethodCellModel(actions: self.cellActions,image:"add-new-beneficiary", title: "Add new debit card"))
    
        let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource)
        let vc = GenericBottomSheetRouter.setupModule(input: input)
        vc.modalPresentationStyle = .overCurrentContext
        UIApplication.getTopViewController()?.present(vc, animated: true)
    }
    
    
    func savedPaymentSource() -> [StandardCellModel]{
        
       return [InSufficientBalanceCreditCardCellModel(cardImage: "visa-card-icon",
                                                      cardType:"VISA card",
                                                      cardNumber:"Debit card **** 1528",
                                                      trailingButtonTitle:Strings.Generic.change)]
    }
    func notSavedPaymentSource() -> [StandardCellModel]{
        return [InSufficientBalanceCreditCardCellModel(cardImage: "debit-card",
                                                       cardType:Strings.Generic.debit_card,
                                                       cardNumber:Strings.Generic.hundred_secure_transfers, trailingButtonTitle:Strings.Generic.add)]
    }
    
    @objc func confirmButtonTapped(){
        
    }
    private func setupCellActions() {
            cellActions = StandardCellActions{ index, model in
                UIApplication.getTopViewController()?.dismiss(animated: true, completion: {
                    //Initiate the Registration Process here
                    print("Row Tapped...")
                })
            }
        }
                          }
