//
//  BillPaymentAPIRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 05/06/2023.
//

import Foundation


enum BillPaymentAPIRouter: RequestProtocol {
    case getBillTypes
    case savedBills
    case getSMSDetails
    case getLookups(type:String,fieldText:String)
    case getResourceList(_ listType:String)
    case submitBill(data: BillPaymentCheckoutRequest)
    case submitMobileInternational(data: BillPaymentCheckoutRequest)
    case getProducts(accountNumber: String, countryISO: String)
    case getTransactionHistory(id: String)
    case getParkingZones
    case payBill(serviceId:String,_ data:[[String:Any]])
    case addBeneficiary(data: AddVehicleRequestModel)
    case getRecentParkings
    case addParking(_ parking:ParkingRequestModel)
    case getBills(data: BillRequestModel)
    
    var path: String {
        switch self {
        case .getBillTypes:
            return EndPoints.BillPayment.getBillTypes
        case .savedBills:
            return EndPoints.BillPayment.savedBills
        case .getSMSDetails:
            return EndPoints.BillPayment.getSMSDetails
        case .getResourceList:
            return EndPoints.BillPayment.resourceList
        case .getLookups:
            return EndPoints.BillPayment.resourceLookups
        case .submitBill:
            return EndPoints.BillPayment.submitBill
        case .getTransactionHistory:
            return EndPoints.BillPayment.getTransactionHistory
        case .getProducts:
            return EndPoints.BillPayment.getProducts
        case .submitMobileInternational:
            return EndPoints.BillPayment.submitMobileInternational
        case .getParkingZones:
            return EndPoints.BillPayment.mParkingZones
        case .payBill:
            return EndPoints.BillPayment.payBill
        case .addBeneficiary:
            return EndPoints.BillPayment.addBeneficiary
        case .getRecentParkings:
            return EndPoints.BillPayment.recentParkings
        case .addParking:
            return EndPoints.BillPayment.addRecentParkings
        case .getBills:
            return EndPoints.BillPayment.getBills

        }
    }
    
    var params: [String:Any] {
        switch self {
        case .getBillTypes:
            return ["codeType": "BILL_TOPUP_TYPES"]
        case .savedBills:
            return ["": ""]
        case .getSMSDetails:
            return ["cityCode":"AUD",
                    "noOfHours":"2",
                    "parkingZone":"669",
                    "plateNo":"212",
                    "plateNoSource":""]
        case .getResourceList(let type):
            return ["listType":type]
        case let .getLookups(type,fieldText):
            return ["fieldKey":type,"fieldText":fieldText]
        case let .submitBill(data):
            var params: [String: Any] = [:]
            params = [
                     "accountNumber": data.accountNumber ?? "",
                     "accountTitle": data.accountTitle ?? "",
                     "amount": data.amountDue ?? "",
                     "amountDue": data.amount ?? "",
                     "providerTransactionId": data.providerTransaction ?? "",
                     "senderMsisdn": data.senderMsisdn ?? "",
                     "serviceId": data.serviceId ?? "",
                     "transactionId": data.transactionId ?? "",
                     "transactionType": "COLBILL",
                     "transferType": "payBill",
                     "msisdn": GlobalData.shared.msisdn ?? "",
                     "pin": UserDefaultHelper.userLoginPin ]
            if data.providerPin != nil {
                //params["pin"] =  data.pin ?? ""
                params["providerPin"] = data.providerPin

            }
            return params
        case let .getTransactionHistory(id):
            return ["transactionNumber": id]
        case let .submitMobileInternational(data):
           return [
            "currencyIso": "AED",
            "receiverMsisdn": "920000000000",
            "skuCode": "PK_MB_TopUp_100.00",
                    "accountTitle": data.accountTitle ?? "",
                    "amount": data.amountDue ?? "",
                    "amountDue": data.amount ?? "",
                    "senderMsisdn": data.senderMsisdn ?? "",
                    "serviceId": data.serviceId ?? "",
                    "transactionType": "COLBILL",
                    "transferType": "TopUp",
                    "msisdn": GlobalData.shared.msisdn ?? "",
                    "pin": UserDefaultHelper.userLoginPin ]
        case let .getProducts(accountNumber, countryISO):
            return [
                "accountNumber": accountNumber,
                "countryISO": countryISO
            ]
        case .getParkingZones:return [:]
        case let .payBill(serviceId, data):
            return ["additional":data,
                    "pin":/UserDefaultHelper.userLoginPin,
                    "accountNumber":/UserDefaultHelper.msisdn,
                    "flowName":"Upgrade",
                    "linkedAccount":false,
                    "serviceId":serviceId]
        case let .addBeneficiary(data):
            return data.dictionary
        case .getRecentParkings:
            return [:]// ["flowName":"Upgrade",]
        case .addParking(let parking):
            return parking.dictionary
        case let .getBills(data):
            return data.dictionary
        }
    }
    var requestType: RequestType {
        switch self {
        case .getBillTypes, .savedBills,.getSMSDetails,.getResourceList,.getLookups,.submitBill, .getTransactionHistory, .submitMobileInternational, .getProducts,.getParkingZones,.payBill,.addBeneficiary,.getRecentParkings,.addParking,.getBills:
            return .POST
        }
    }
}
