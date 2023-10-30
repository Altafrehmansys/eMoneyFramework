//
//  NotificationNameExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 26/04/2023.
//

import Foundation

extension Notification.Name {
    static let appSessionExpired = Notification.Name("NotificationSessionExpired")
    static let onUpgradeFlowCompletion = Notification.Name(rawValue: "onUpgradeFlowCompletion")
    static let onChangeScreenSize = Notification.Name(rawValue: "onChangeScreenSize")
}
