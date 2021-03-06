//
//  SharedDefaults.swift v.0.2.0
//  SwiftRfUtil
//
//  Created by Rudolf Farkas on 13.03.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import Foundation

/// Wrapper CodableUserDefault<Key, Value>
/// enables creation of variables of any type conforming to Codable protocol
/// that are stored in UserDefaults that can be local to app or shared between apps.
@propertyWrapper
struct CodableUserDefault<Key: RawRepresentable, Value: Codable> where Key.RawValue == String {
    let key: Key
    let defaultValue: Value
    private var userDefaults: UserDefaults

    init(key: Key, defaultValue: Value, userDefaults: UserDefaults = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    var wrappedValue: Value {
        get {
            var value = defaultValue
            if let data = userDefaults.data(forKey: key.rawValue) {
                do {
                    value = try JSONDecoder().decode(Value.self, from: data)
                } catch {}
            }
            return value
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefaults.set(data, forKey: key.rawValue)
        }
    }
}
/// Wrapper PlistUserDefault<Key, Value>
/// enables creation of variables of any type that can be stored in a .plist
/// (Data, String, Number, Date, Array and Dictionary)
/// that are stored in UserDefaults that can be local to app or shared between apps.
@propertyWrapper
struct PlistUserDefault<Key: RawRepresentable, Value> where Key.RawValue == String {
    let key: Key
    let defaultValue: Value
    var userDefaults: UserDefaults = .standard

    init(key: Key, defaultValue: Value, userDefaults: UserDefaults = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    var wrappedValue: Value {
        get {
            let value = userDefaults.value(forKey: key.rawValue) as? Value
            return value ?? defaultValue
        }
        set {
            userDefaults.setValue(newValue, forKey: key.rawValue)
        }
    }
}


