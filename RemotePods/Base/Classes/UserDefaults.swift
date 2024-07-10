//
//  UserDefaults.swift
//  Base
//
//  Created by zhaoshouwen on 2024/7/8.
//

import Foundation

@propertyWrapper
public struct UserDefaultOptional<T> {
    let key: String
 
    public init(key: String, default: T?) {
        self.key = "com.mediator." + key
        wrappedValue = UserDefaults.standard.object(forKey: self.key) as? T ?? `default`
    }
 
    public var wrappedValue: T? {
        willSet {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}
 
@propertyWrapper
public struct UserDefault<T> {
    let key: String
    public init(key: String, default: T) {
        self.key = "com.mediator." + key
        wrappedValue = UserDefaults.standard.object(forKey: self.key) as? T ?? `default`
    }
    
    public var wrappedValue: T {
        willSet {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
public struct UserDefaultCodable<T: Codable> {
    let key: String
    public init(wrappedValue: T, key: String) {
        self.key = "com.mediator." + key
        self.wrappedValue = UserDefaults.standard.object(T.self, with: self.key) ?? wrappedValue
    }
    
    public var wrappedValue: T {
        willSet {
            UserDefaults.standard.set(object: newValue, forKey: key)
        }
    }
}

extension UserDefaults {

    /// SwifterSwift: Retrieves a Codable object from UserDefaults.
    ///
    /// - Parameters:
    ///   - type: Class that conforms to the Codable protocol.
    ///   - key: Identifier of the object.
    ///   - decoder: Custom JSONDecoder instance. Defaults to `JSONDecoder()`.
    /// - Returns: Codable object for key (if exists).
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = data(forKey: key) else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    /// SwifterSwift: Allows storing of Codable objects to UserDefaults.
    ///
    /// - Parameters:
    ///   - object: Codable object to store.
    ///   - key: Identifier of the object.
    ///   - encoder: Custom JSONEncoder instance. Defaults to `JSONEncoder()`.
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        set(data, forKey: key)
    }

}
