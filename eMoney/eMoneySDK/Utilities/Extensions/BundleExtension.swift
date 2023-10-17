//
//  BundleExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 07/03/2023.
//

import Foundation
import UIKit

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var releaseBuildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    func decode<T: Codable>(_ file: String) -> T {
            guard let url = self.url(forResource: file, withExtension: nil) else {
                fatalError("Failed to locate \(file) in bundle.")
            }

            guard let data = try? Data(contentsOf: url) else {
                fatalError("Failed to load \(file) from bundle.")
            }

            let decoder = JSONDecoder()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "y-MM-dd"
//            decoder.dateDecodingStrategy = .formatted(formatter)

            guard let loaded = try? decoder.decode(T.self, from: data) else {
                fatalError("Failed to decode \(file) from bundle.")
            }

            return loaded
        }
}

