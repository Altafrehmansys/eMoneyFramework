//
//  DateExtension.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 06/06/2023.
//

import Foundation

extension Date {
    
    enum Formate: String {
        case fullDateTime = "MMM dd, yyyy 'at' hh:mm a"
        case hourMin = "hh:mm"
        case universalTime = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
    }
    
    func formate(with formate: Formate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate.rawValue
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func getHoursAndMintutes() -> (String, String) {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "GMT") ?? .current
        let components = calendar.dateComponents([.hour, .minute], from: self)

        if let hour = components.hour, let minute = components.minute {
            
            let formattedHours = String(format: "%02d", hour)
            let formattedMinute = String(format: "%02d", minute)
            
            return (formattedHours, formattedMinute)
        } else {
            print("Failed to extract hour and minute from the date.")
        }
        return ("","")
    }
}

extension String {
    func formate(with formate: Date.Formate) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        let date = dateFormatter.date(from: self)
        return date!
    }
}
