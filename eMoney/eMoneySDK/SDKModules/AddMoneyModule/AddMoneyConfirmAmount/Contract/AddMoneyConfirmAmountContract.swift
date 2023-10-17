//
//  AddMoneyAddAmountContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//  
//

import Foundation

protocol AddMoneyConfirmAmountViewProtocol: ViperView {
    var presenter: AddMoneyConfirmAmountPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
}

protocol AddMoneyConfirmAmountPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get set }
    var isCollapsed: Bool { get set }
    
    var title: String { get set }
    var subtitle: String { get set }
    var logo: String { get set }
    var amount: String { get set }
    var currentFlow: CashInFlowType { get set }
    
    func loadData()
    func makeDataSource()
    func nextButtonTapped()
    
    // Navigations
    func goBack()
    func loadOTPScreen(msisdn: String, addingText:String, amount: String, toTitle: String)
}

protocol AddMoneyConfirmAmountInteractorProtocol: ViperInteractor {
    func getPaymentIntetnt(request: PaymentIntentRequestModel)
    func getPaymentGatewayDetails(request: UaePgsRequestModel)
    func initializeCardPayment(with card: CardResponseObjectModel.CardResponseObjectDataModel, and amount: String)
    func updatePaymentIntentStatus(with paymentIntentID: String)
}

protocol AddMoneyConfirmAmountInteractorOutputProtocol: AnyObject {
    func onPaymentIntentResponse(response: PaymentIntentResponseModel)
    func onFetchPaymentIntentError(error : AppError)
    
    func onPaymentGatewayDetails(response: UaePgsResponseModel)
    func onPaymentGatewayDetails(error: AppError)
    
    func onCardPaymentInitialized(response: InitializeCardPaymentResponseModel)
    func onCardPaymentInitialization(error: AppError)
    
    func onPaymentIntentStatus(response: PaymentIntentStatusResponseModel)
    func onPaymentIntentStatus(error: AppError)
}

protocol AddMoneyConfirmAmountRouterProtocol: ViperRouter {
    func go(to route: AddMoneyConfirmAmountRouter.Route)
    func navigateToPayLeanSDK(paymentIntent: String, selectedSouceBankID: String)
}
