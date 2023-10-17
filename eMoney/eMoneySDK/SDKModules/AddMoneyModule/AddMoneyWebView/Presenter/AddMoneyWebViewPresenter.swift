//
//  AddMoneyWebViewPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 01/05/2023.
//  
//

import Foundation

class AddMoneyWebViewPresenter {

    // MARK: Properties
    weak var view: AddMoneyWebViewViewProtocol?
    var router: AddMoneyWebViewRouterProtocol?
    var interactor: AddMoneyWebViewInteractorProtocol?
    
    var request: URLRequest?
    var flowType: CashInFlowType = .none
    var selectedAmount: String = ""
    var selectedCardName: String = ""
}

extension AddMoneyWebViewPresenter: AddMoneyWebViewPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
    }
    
    func goBack() {
        self.router?.go(to: .back)
    }
}

// MARK: - Extract data from Webpage Response
extension AddMoneyWebViewPresenter {
    func extractData(from response: Dictionary<AnyHashable, Any>) {
        switch flowType {
        case .bankAcount:
            self.extractFromEPGBank(from: response)
            
        case .debitCard, .initializeDebitCard:
            self.extractFromEPGCard(from: response)
            
        default:
            break
        }
    }
}

// MARK: - Extract Data for Bank account
extension AddMoneyWebViewPresenter {
    private func extractFromEPGBank(from response: Dictionary<AnyHashable, Any>) {
        if response.keys.contains("EWALLET-PAYMENT-STATUS") || response.keys.contains("ewallet-payment-status") {
            self.view?.stopLoading()
            
            var paymentStatus = ""
            var paymentTitle = ""
            var paymentSubTitle = ""
            var paymentTransactionId = ""
            var paymentBANKNAME = ""
            var paymentIBAN = ""
            var paymentACCOUNTNAME = ""
            var paymentAMOUNT = ""
            var paymentBALANCE = ""
            var paymentDATETIME = ""
            
            if response.keys.contains("EWALLET-PAYMENT-STATUS") {
                paymentStatus = (response["EWALLET-PAYMENT-STATUS"] as! String).lowercased()
            } else if response.keys.contains("ewallet-payment-status") {
                paymentStatus = (response["ewallet-payment-status"] as! String).lowercased()
            }
            
            if response.keys.contains("EWALLET-PAYMENT-TRANSACTIONID") {
                paymentTransactionId = (response["EWALLET-PAYMENT-TRANSACTIONID"] as! String)
            } else if response.keys.contains("ewallet-payment-transactionid") {
                paymentTransactionId = (response["ewallet-payment-transactionid"] as! String)
            }
            
            if response.keys.contains("EWALLET-PAYMENT-TITLE") {
                paymentTitle = (response["EWALLET-PAYMENT-TITLE"] as! String)
            } else if response.keys.contains("ewallet-payment-title") {
                paymentTitle = (response["ewallet-payment-title"] as! String)
            }
            
            
            if response.keys.contains("EWALLET-PAYMENT-MESSAGE") {
                paymentSubTitle = (response["EWALLET-PAYMENT-MESSAGE"] as! String)
            } else if response.keys.contains("ewallet-payment-message") {
                paymentSubTitle = (response["ewallet-payment-message"] as! String)
            }
            
            if response.keys.contains("EWALLET-PAYMENT-BANKNAME") {
                paymentBANKNAME = (response["EWALLET-PAYMENT-BANKNAME"] as! String)
            } else if response.keys.contains("ewallet-payment-bankname") {
                paymentBANKNAME = (response["ewallet-payment-bankname"] as! String)
            }
            
            if response.keys.contains("EWALLET-PAYMENT-IBAN") {
                paymentIBAN = (response["EWALLET-PAYMENT-IBAN"] as! String)
            } else if response.keys.contains("ewallet-payment-iban") {
                paymentIBAN = (response["ewallet-payment-iban"] as! String)
            }
            
            if response.keys.contains("EWALLET-PAYMENT-ACCOUNTNAME") {
                paymentACCOUNTNAME = (response["EWALLET-PAYMENT-ACCOUNTNAME"] as! String)
            } else if response.keys.contains("ewallet-payment-accountname") {
                paymentACCOUNTNAME = (response["ewallet-payment-accountname"] as! String)
            }
            
            if response.keys.contains("EWALLET-PAYMENT-AMOUNT") {
                let amount = (response["EWALLET-PAYMENT-AMOUNT"] as! String)
                let amountInDouble = Double(amount) ?? 0.0
                paymentAMOUNT = Strings.Generic.currency + " " + amountInDouble.formattedPrice
            } else if response.keys.contains("ewallet-payment-amount") {
                let amount = (response["ewallet-payment-amount"] as! String)
                let amountInDouble = Double(amount) ?? 0.0
                paymentAMOUNT = Strings.Generic.currency + " " + amountInDouble.formattedPrice
            }
            
            if response.keys.contains("EWALLET-PAYMENT-BALANCE") {
                paymentBALANCE = (response["EWALLET-PAYMENT-BALANCE"] as! String)
            } else if response.keys.contains("ewallet-payment-balance") {
                paymentBALANCE = (response["ewallet-payment-balance"] as! String)
            }
            
            if response.keys.contains("EWALLET-PAYMENT-DATETIME") {
                paymentDATETIME = (response["EWALLET-PAYMENT-DATETIME"] as! String)
            } else if response.keys.contains("ewallet-payment-datetime") {
                paymentDATETIME = (response["ewallet-payment-datetime"] as! String)
            }
            
            if paymentStatus.lowercased() == "success" || paymentStatus.lowercased() == "successful" {
                let model = FundInResponseModel(paymentTransactionID: paymentTransactionId, paymentTitle: paymentTitle, paymentSubTitle: paymentSubTitle, paymentBANKNAME: paymentBANKNAME, paymentIBAN: paymentIBAN, paymentACCOUNTNAME: paymentACCOUNTNAME, paymentAMOUNT: paymentAMOUNT, paymentBALANCE: paymentBALANCE, paymentDATETIME: paymentDATETIME, paymentStatus: paymentStatus)
                self.navigateToSuccess(model: model)
            } else {
                self.showErrorBottomSheet(with: paymentTitle, and: paymentSubTitle)
            }
        }
    }
}

// MARK: - Extract Data for Bank account
extension AddMoneyWebViewPresenter {
    private func extractFromEPGCard(from response: Dictionary<AnyHashable, Any>) {
        if response.keys.contains("EWALLET-PAYMENT-STATUS") || response.keys.contains("ewallet-payment-status") {
            self.view?.stopLoading()
            var paymentStatus = ""
            var paymentTitle = ""
            var paymentSubTitle = ""
            var paymentTransactionId = ""
            var paymentBANKNAME = ""
            var paymentIBAN = ""
            var paymentACCOUNTNAME = ""
            var paymentAMOUNT = ""
            var paymentBALANCE = ""
            var paymentDATETIME = ""

            
            if response.keys.contains("EWALLET-PAYMENT-STATUS") {
                paymentStatus = (response["EWALLET-PAYMENT-STATUS"] as! String).lowercased()
            } else if response.keys.contains("ewallet-payment-status") {
                paymentStatus = (response["ewallet-payment-status"] as! String).lowercased()
            }
            
            if response.keys.contains("EWALLET-PAYMENT-TRANSACTIONID") {
                paymentTransactionId = (response["EWALLET-PAYMENT-TRANSACTIONID"] as! String)
            } else if response.keys.contains("ewallet-payment-transactionid") {
                paymentTransactionId = (response["ewallet-payment-transactionid"] as! String)
            }
            
            if response.keys.contains("EWALLET-PAYMENT-TITLE") {
                paymentTitle = (response["EWALLET-PAYMENT-TITLE"] as! String)
            } else if response.keys.contains("ewallet-payment-title") {
                paymentTitle = (response["ewallet-payment-title"] as! String)
            }
            
            
            if response.keys.contains("EWALLET-PAYMENT-MESSAGE") {
                paymentSubTitle = (response["EWALLET-PAYMENT-MESSAGE"] as! String)
            } else if response.keys.contains("ewallet-payment-message") {
                paymentSubTitle = (response["ewallet-payment-message"] as! String)
            }
            
            if response.keys.contains("EWALLET-PAYMENT-DATETIME") {
                paymentDATETIME = (response["EWALLET-PAYMENT-DATETIME"] as! String)
            } else if response.keys.contains("ewallet-payment-datetime") {
                paymentDATETIME = (response["ewallet-payment-datetime"] as! String)
            }
            
            paymentBANKNAME = self.selectedCardName
            
            let amountInDouble = Double(self.selectedAmount) ?? 0.0
            paymentAMOUNT = Strings.Generic.currency + " " + amountInDouble.formattedPrice
            
            let amount = Double(self.selectedAmount) ?? 0.0
            let walletBalance = GlobalData.shared.availableBalance?.balance ?? 0.0
            let totalBalance = walletBalance + amount
            paymentBALANCE = totalBalance.formattedPrice
            
            if paymentStatus.lowercased() == "success" || paymentStatus.lowercased() == "successful" {
                if flowType == .initializeDebitCard {
                    router?.go(to: .updateRootVC(message: paymentSubTitle))
                    router?.go(to: .back)
                } else {
                    let model = FundInResponseModel(paymentTransactionID: paymentTransactionId, paymentTitle: paymentTitle, paymentSubTitle: paymentSubTitle, paymentBANKNAME: paymentBANKNAME, paymentIBAN: paymentIBAN, paymentACCOUNTNAME: paymentACCOUNTNAME, paymentAMOUNT: paymentAMOUNT, paymentBALANCE: paymentBALANCE, paymentDATETIME: paymentDATETIME, paymentStatus: paymentStatus)
                    self.navigateToSuccess(model: model)
                }
            } else {
                self.showErrorBottomSheet(with: paymentTitle, and: paymentSubTitle)
            }
        }
    }
    
    private func navigateToSuccess(model: FundInResponseModel) {
        let input = AddMoneySuccessRouter.Input(title: Strings.AddMoney.fundsAddedSuccessfully, amount: model.paymentAMOUNT, currentFlow: flowType, cashInWithBank: model)
        router?.go(to: .loadSuccessScreen(input: input))
    }
    
    private func showErrorBottomSheet(with title: String, and message: String) {
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong,
                                   message: message,
                                   actionBtnTitle: Strings.Generic.tryAgain,
                                   secondryBtnTitle: Strings.AddMoney.tryUsingAnotherMethod,
                                   delegate: self)
    }
}


// MARK: - General Bottom Sheet Error View Delegate Method
extension AddMoneyWebViewPresenter: GeneralBottomSheetErrorViewDelegate {
    func tryAgainBtnTapped(index: Int) {
        self.view?.reloadWebView(isHidden: false)
    }
    
    
    func secondryBtnTapped() {
        self.router?.go(to: .back)
    }
}

extension AddMoneyWebViewPresenter: AddMoneyWebViewInteractorOutputProtocol {
    
}
