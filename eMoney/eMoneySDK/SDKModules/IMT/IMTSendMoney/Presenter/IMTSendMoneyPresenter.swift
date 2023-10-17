//
//  IMTSendMoneyPresenter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 30/05/2023.
//  
//

import Foundation
import UIKit

class IMTSendMoneyPresenter {

    // MARK: Properties

    weak var view: IMTSendMoneyViewProtocol?
    var router: IMTSendMoneyRouterProtocol?
    var interactor: IMTSendMoneyInteractorProtocol?
    
    var cellAction: StandardCellActions?
    
    var selectedSegmentIndex = 0
    
    var senderFieldError:String? = nil
    var receiverFieldError:String? = nil
    var selectedCountry: Countries? = nil {
        didSet{
            makeDataSource()
        }
    }
    private var minBalanceRequired = 1.0
    private var senderAmount:Double? = nil
    private var receiverAmount:Double? = nil
    private var vatTax = 5.0
    private var transactionFee = 5.0
    private var exchangeRate: String = "70.0"
    
    var dataSource:[StandardCellModel] = []
}

extension IMTSendMoneyPresenter: IMTSendMoneyPresenterProtocol {
    
    
    
    func loadData() {
        setupCellActions()
        makeDataSource()
    }
    
    func makeDataSource() {
        dataSource = []
        
        dataSource.append(GenericSingleLabelCellModel(content: "Transfer method",font: AppFont.appSemiBold(size: .body2), topSpace: 20,bottomSpace: 12))
        
        dataSource.append(IMTSegmentCellModel(actions: cellAction, title: ["Bank account","Cash pick-up","Mobile wallet"], type: .label, selectedIndex: self.selectedSegmentIndex))
        
        dataSource.append(IMTTransferMethodDetailCellModel(data: ""))
//        dataSource.append(SpaceTableViewCellModel(height: 12))

        
        
        dataSource.append(GenericSingleLabelCellModel(content: "Transfer amount",font: AppFont.appSemiBold(size: .body2),bottomSpace: 12))
        
        
        dataSource.append(IMTAmountFieldCellModel(actions: cellAction, isReceiverField: false, countryCode: "AED", countryFlag: "flag_united_arab_emirates",errorMsg: senderFieldError,amount: senderAmount))
        dataSource.append(SpaceTableViewCellModel(height: 12))
        dataSource.append(IMTAmountFieldCellModel(actions: cellAction, isReceiverField: true, countryCode: selectedCountry?.code ?? "", countryFlag: CountriesMapping(rawValue: selectedCountry?.code ?? "")?.countryFlag ?? "default-flag",amount: receiverAmount))
        
        

        view?.reloadData(data: dataSource)
    }
    
    private func setupCellActions() {
        cellAction = StandardCellActions {[weak self] index, model in
            guard let strongSelf = self else { return }
            
            if let model = model as? IMTSegmentCellModel{
                if model.segmentType == .label {
                    self?.selectedSegmentIndex = index
                }
                strongSelf.senderFieldError = nil
                strongSelf.makeDataSource()
                print("Segment index",index)
            }else if let model = model as? IMTAmountFieldCellModel{
                
                if index == 0 {
                    if model.isReceiverField {
                        self?.router?.go(to: .countrySelection)
                    }
                }else if index == 1{
                    //TextField did end editing
                    guard var actualAmount = model.amount else{
                        strongSelf.senderAmount = nil
                        strongSelf.receiverAmount = nil
                        strongSelf.makeDataSource()
                        return
                    }
                    
                    guard let exchangeRate = Double(strongSelf.exchangeRate) else { return }
                    
                    if model.isReceiverField {
                        strongSelf.receiverAmount = actualAmount
                        actualAmount = Double(actualAmount / exchangeRate)
                        strongSelf.senderAmount = actualAmount
                    }else{
                        strongSelf.senderAmount = actualAmount
                        strongSelf.receiverAmount = actualAmount * exchangeRate
                    }
                    guard let balance = GlobalData.shared.availableBalance?.balance else { return }
                    
                    let isValidAmount = strongSelf.getTotalAmount(actualAmount: actualAmount) <= balance ? true : false
                    
                    if !isValidAmount {
                        strongSelf.senderFieldError = "Unfortunately, you have insufficient funds at the moment."
                        strongSelf.makeDataSource()
                    } else if actualAmount < strongSelf.minBalanceRequired {
                        strongSelf.senderFieldError = "Min value is 1 AED"
                        strongSelf.makeDataSource()
                    }else{
                        strongSelf.senderFieldError = nil
                        strongSelf.makeDataSource()
                    }
                }
                
            }
            
        }
    }
    
    func getTotalAmount(actualAmount: Double) -> Double {
//        var vatAmount = Double(CommonMethods.calculateServiceCharges(withVat: "\(vatTax)", andServicesCharges: "\(transactionFee)")) ?? 0.0
//        vatAmount = vatAmount - transactionFee
        let vatAmount = vatTax.roundTo(places: 2)
        
        var totalAmount = actualAmount + transactionFee + vatAmount
        totalAmount = totalAmount.roundTo(places: 2)
        return totalAmount
    }
}

extension IMTSendMoneyPresenter: IMTSendMoneyInteractorOutputProtocol {
    
}
