//
//  DictionaryExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 09/03/2023.
//

import Foundation

extension Dictionary where Key: Codable, Value: Codable {
    static func load(fromFileName fileName: String) -> [Key: Value]? {
        
        let fileManager = FileManager.default
        
        let fileURL = Self.getDocumentsURL(withName: fileName, using: fileManager)
        guard let data = fileManager.contents(atPath: fileURL.path) else {
            print("\(#function) not loaded")
            return nil
        }
        do {
            return try JSONDecoder().decode([Key: Value].self, from: data)
        } catch(let error) {
            print(error)
            return nil
        }
    }

    func saveToDisk(withName name: String) throws {
        let fileManager = FileManager.default
        let fileURL = Self.getDocumentsURL(withName: name, using: fileManager)
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }

    private static func getDocumentsURL(withName name: String,
                                 using fileManager: FileManager) -> URL {

        let folderURLs = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = folderURLs[0].appendingPathComponent(name)
        return fileURL
    }
}
