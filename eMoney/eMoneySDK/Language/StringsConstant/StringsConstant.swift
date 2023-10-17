//
//  StringsConstant.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 30/05/2023.
//

import Foundation

struct Strings {
    struct Generic {
        static var ok: String {
            return "ok".localized
        }
        static var error: String {
            return "error".localized
        }
        static var cancel: String {
            return "cancel".localized
        }
        static var somethingWentWrong: String {
            return "somrthing_went_wrong".localized
        }
        static var generalErrorMsg: String {
            return "splash_error".localized
        }
        static var currency: String {
            return "aed".localized
        }
        static var tryAgain: String {
            return "try_again".localized
        }
        static var insufficient_balance: String {
            return "insufficient_balance".localized
        }
        static var select_source_to_add_remaining_amount: String {
            return "select_source_to_add_remaining_amount".localized
        }
        static var payment_source: String {
            return "payment_source".localized
        }
        static var change: String {
            return "change".localized
        }
        static var payment_details: String {
            return "payment_details".localized
        }
        static var wallet_balance: String {
            return "wallet_balance".localized
        }
        static var balance_to_be_added: String {
            return "balance_to_be_added".localized
        }
        static var total_to_be_deducted: String {
            return "total_to_be_deducted".localized
        }
        static var confirm_btn_text: String {
            return "confirm_btn_text".localized
        }
        static var debit_card: String {
            return "debit_card".localized
        }
        static var add: String {
            return "add".localized
        }
        static var hundred_secure_transfers: String {
            return "hundred_secure_transfers".localized
        }
    }
    
    struct KYCBottomSheet {
        
        static var upgradeIsRequired: String {
            return "upgrade_is_required".localized
        }
        static var identity_verification_required: String {
            return "identity_verification_required".localized
        }
        static var scan_your_Emirates_ID: String {
            return "scan_your_Emirates_ID".localized
        }
        static var emirates_smart_card_ID: String {
            return "emirates_smart_card_ID".localized
        }
        static var take_pictures_both_sides: String {
            return "take_pictures_both_sides".localized
        }
        static var uploadEmiratesIDForLimitless: String {
            return "upload_emirates_id_for_limitless_functionality".localized
        }
        static var scanYourEID: String {
            return "scan_your_eid_to_complete_registration".localized
        }
    }
}
