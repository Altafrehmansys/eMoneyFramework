//
//  UIViewControllerExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 16/03/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    enum AppStoryboard: String {
        case Onboarding = "Onboarding"
        case Splash = "Splash"
        case RegisterMobileNumber     = "RegisterMobileNumber"
        case VerifyMobileNumber     = "VerifyMobileNumber"
        case WalkthroughIntro     = "WalkthroughIntro"
        case SelectLanguage = "SelectLanguage"
        case CaptureIdentityInfo = "CaptureIdentityInfo"
        case MDRModule = "MDRModule"
        case ReviewEid = "ReviewEid"
        case Liveness = "Liveness"
        case RegisterEmail = "RegisterEmail"
        case RegisterPin = "RegisterPin"
        case ReEnterPin = "ReEnterPin"
        case EnableNotification = "EnableNotification"
        case GenericBottomSheet = "GenericBottomSheet"
        case SelectCard = "SelectCard"
        case AddAppleWallet = "AddAppleWallet"
        case KickstartSuccess = "KickstartSuccess"
        case AddMoney = "AddMoney"
        case AddMoneySDK = "AddMoneySDK"
        case AddMoneySelectBank = "AddMoneySelectBank"
        case AddMoneyVerifyBank = "AddMoneyVerifyBank"
        case AddMoneyEnterAmount = "AddMoneyEnterAmount"
        case AddMoneyConfirmAmount = "AddMoneyConfirmAmount"
        case AddMoneyWebView = "AddMoneyWebView"
        case AddMoneySuccess = "AddMoneySuccess"
        case PaymentMachines = "PaymentMachines"
        case AgentsAndMachine = "AgentsAndMachine"
        case BillsAndTopsUp = "BillsAndTopsUp"
        case AccountDetails = "AccountDetails"
        case SelectPlan = "SelectPlan"
        case BillPaymentCheckout = "BillPaymentCheckout"
        case BillPaymentSuccess = "BillPaymentSuccess"
        case SendMoney                 =    "SendMoney"
        case SendMoneyToBankAccount    =    "SendMoneyToBankAccount"
        case SendMoneyEnterAmount      =    "SendMoneyEnterAmount"
        case SendMoneyPaymentDetails   =    "SendMoneyPaymentDetails"
        case AddBankBeneficiary        =    "AddBankBeneficiary"
        case SendMoneySuccess          =    "SendMoneySuccess"
        case AddNewCard = "AddNewCard"
        case AddMoneyScanCard = "AddMoneyScanCard"
        case ManageSavedAccounts = "ManageSavedAccounts"
        case ManageSavedCard = "ManageSavedCard"
        case MParkingDetails = "MParkingDetails"
        case AddBeneficiary = "AddBeneficiary"
        case ParkingSMSCopy = "ParkingSMSCopy"
        case AddNewVehicle = "AddNewVehicle"
        case AddParkingLocation = "AddParkingLocation"
        case RecentParking = "RecentParking"
//        case Login      = "Login"

        case Thankyou = "Thankyou"
        case FailedOtp = "FailedOtp"
        case Login = "Login"
        case TermsConditions = "TermsConditions"

        case ScanQRCodeToPay           =    "ScanQRCodeToPay"
        case MyBeneficiaries           =    "MyBeneficiaries"
        case BankBeneficiaryDetail     =    "BankBeneficiaryDetail"
        case MobileBeneficiaryDetail   =    "MobileBeneficiaryDetail"
        case EmployeeBeneficiaryDetail =    "EmployeeBeneficiaryDetail"
        case SavedBillsAndTopsUp       =    "SavedBillsAndTopsUp"
        case AddMobileBillAccount                  =    "AddMobileBillAccount"
        case AddBillsEnterAmount                  =    "AddBillsEnterAmount"
        case AddMobileBillPaymentDetail                  =    "AddMobileBillPaymentDetail"
        case MobileBillPaymentSuccessfull                  =    "MobileBillPaymentSuccessfull"
        case AllSavedBills                  =    "AllSavedBills"
        
        case BottomSheetCollectionView      =    "BottomSheetCollectionView"
        case BillAccountDetails      =    "BillAccountDetails"
        case DueBills      =    "DueBills"
        case BillManagement = "BillManagement"
        case VehiclesAndTransportDetail = "VehiclesAndTransportDetail"
        case VehiclesAndTransportFinesDetails = "VehiclesAndTransportFinesDetails"
        case FineDetail = "FineDetail"
        
        case BankAlert = "BankAlert"

        case LoginNumber = "LoginNumber"
        case Home = "Home"
        case AddRecipent = "AddRecipent"
        case Summary = "Summary"
        case OtpMoney = "OtpMoney"
        case SenderDetail = "SenderDetail"
        case TransferStatus = "TransferStatus"
        case SuccessfulTransfer = "SuccessfulTransfer"
        case GenericFetchAccountDetailsWithLoader = "GenericFetchAccountDetailsWithLoader"
        case AddReceipt = "AddReceipt"
        case SavedBillsDetails = "SavedBillsDetails"
        case CountrySelection = "CountrySelection"
        case DueBillsDetail = "DueBillsDetail"
        case DEWASendMoneyPaymentDetails = "DEWASendMoneyPaymentDetails"
        case SendMoneyDEWASuccess = "SendMoneyDEWASuccess"
        case OtpPopup = "OtpPopup"
        case IMTSelectTransferMethod = "IMTSelectTransferMethod"
        case IMTSendMoney = "IMTSendMoney"
        case ImtTermsCondition = "ImtTermsCondition"
        case WalkthroughImt = "WalkthroughImt"
        case SendAbroad = "SendAbroad"
        case ForgotPassword = "ForgotPassword"
        case AlternateFlowForLean = "AlternateFlowForLean"
        case LeanCoolOffBottomSheet = "LeanCoolOffBottomSheet"
        case Wallet = "Wallet"
        case WalletCheckout = "WalletCheckout"
        case WalletCardSuccess = "WalletCardSuccess"
        case CardDetails = "CardDetails"
        case ChangeCardPin = "ChangeCardPin"
        case ManageCard = "ManageCard"
        case EAndMoneyAccounts = "EAndMoneyAccounts"
        case EnterYourPIN = "EnterYourPIN"
        case SetUpNewPIN = "SetUpNewPIN"
        case ReEnterYourPIN = "ReEnterYourPIN"
        case ReportLostCard = "ReportLostCard"
        case CancelCard = "CancelCard"
        case CardAccountLimits = "CardAccountLimits"
        case PinSuccessful = "PinSuccessful"
             
        var instance: UIStoryboard {
            return UIStoryboard(name: rawValue, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!)
        }
        
        func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
            let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
            return instance.instantiateViewController(withIdentifier: storyboardID) as! T
        }
        
        func initialViewController() -> UIViewController? {
            return instance.instantiateInitialViewController()
        }
    }

}

extension UIViewController {
    
    func add(_ child: UIViewController, view:UIView? = nil) {
            addChild(child)
            let _view:UIView = view ?? self.view
            child.view.frame = _view.bounds
            _view.addSubview(child.view)
            child.didMove(toParent: self)
        }
        
        func removeChildView() {
            guard parent != nil else {
                return
            }
            
            willMove(toParent: nil)
            view.removeFromSuperview()
            removeFromParent()
        }

}
