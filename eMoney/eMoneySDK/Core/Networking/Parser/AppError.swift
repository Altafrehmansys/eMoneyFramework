//
//  AppError.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 26/04/2023.
//

import Foundation

struct AppError : Error {
    let errorDescription : String
    let errorCode : String
    let title: String
}
