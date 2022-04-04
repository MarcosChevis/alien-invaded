//
//  Settings.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 03/04/22.
//

import Foundation

@propertyWrapper
struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

struct Settings {
    @Storage(key: "is_sfx_enabled", defaultValue: true)
    static var isSfxEnabled: Bool
    
    @Storage(key: "is_music_enabled", defaultValue: true)
    static var isMusicEnabled: Bool
}
