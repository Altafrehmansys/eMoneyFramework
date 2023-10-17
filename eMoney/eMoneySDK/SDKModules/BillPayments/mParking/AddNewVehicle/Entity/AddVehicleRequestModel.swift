//
//  AddVehicleRequestModel.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 27/07/2023.
//

import Foundation

struct AddVehicleRequestModel {
    let region: String
    let plateKind: String
    let plateCode: String
    let plateNumber: String

    
    var dictionary:[String: Any] {
        return  [
            "billTypeId": 22,
            "billTypeName": "mParking",
            "notificationEnabledFlag": false,
            "editableFlag": false,
           // "plainPin": "string",
            "additionalInfo": [["name":/self.region,
                               "value":/self.plateKind]],
            "accountNumber" : /self.plateNumber,
            "accountTitle": /self.plateCode,
            "pin": /UserDefaultHelper.userLoginPin,
        //    "plainPin": "string",
          //  "processId": "string",
           // "transactionId": "string",
        ]
    }
}
 
