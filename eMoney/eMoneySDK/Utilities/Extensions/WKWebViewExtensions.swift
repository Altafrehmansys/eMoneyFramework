//
//  WKWebViewExtensions.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 21/06/2023.
//

import WebKit


extension WKWebView {
    class func clean() {
        guard #available(iOS 9.0, *) else {return}

        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("WKWebsiteDataStore record deleted:", record)

            }
        }
    }
}
