//
//  Environment.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 27/05/2024.
//

import Foundation

public enum Environment {

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    static func getValue(for key: Keys.Plist) -> String {
        guard let value = Environment.infoDictionary[key.rawValue] as? String else {
            fatalError("Key \(key) not set in plist for this environment")
        }
        return value
    }
}
