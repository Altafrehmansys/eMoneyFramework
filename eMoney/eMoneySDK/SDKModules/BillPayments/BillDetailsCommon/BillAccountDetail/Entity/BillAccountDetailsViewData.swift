//
//  BillAccountDetailsViewData.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 21/06/2023.
//

import Foundation

struct BillAccountDetailsViewData {
    var navTitle: String = ""
    var selectedItem: ListItems? = nil
    var selectItemType: BillsAnsTopUpType = .none
    var inputPhoneNumber: String = ""
    var inputName: String = ""
    var inputPin: String = ""
    var isSavedForFuture = true
    var isprepaidSelected:Bool = true
    var countryCodesList: [String]?
}
