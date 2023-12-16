//
//  UserDefaultsManager.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/14.
//

import Foundation

struct UserDefaultsManager {
    @UserDefaultsWrapper(key: UserDefaultKeys.isShownAlarmPopup, value: false)
    static var isShownAlarmPopup: Bool?
}

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {
    
    private let key: UserDefaultKeys
    private let defaultValue: T?
    
    init(key: UserDefaultKeys, value: T?) {
        self.key = key
        self.defaultValue = value
    }
    
    var wrappedValue: T? {
        get {
            guard let loadData = UserDefaults.standard.object(forKey: self.key.rawValue) as? Data,
                  let decodeData = try? JSONDecoder().decode(T.self, from: loadData) else {
                return defaultValue
            }
            return decodeData
        }
        
        set {
            if let encodeData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodeData, forKey: self.key.rawValue)
            }
        }
    }
}
