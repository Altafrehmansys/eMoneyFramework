//
//  DataExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 08/03/2023.
//

import Foundation

extension Data {
    func prettyJSONString() -> String? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) {
            if let prettyPrintedData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                return String(bytes: prettyPrintedData, encoding: String.Encoding.utf8) ?? nil
            }
        }
        return nil
    }
}
